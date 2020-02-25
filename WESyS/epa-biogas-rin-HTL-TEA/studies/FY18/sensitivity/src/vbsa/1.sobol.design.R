# Create VBSA Study 
# D.Inman and A.Eberle
# 18 Jan 2018  

design.vbsa.study <- function(region, type, vbsa_study_extension, config_file) {
  print(region)
  print(type)
  
  # Source R script config file and define variables from file 
  source(config_file)
  define.variables()
  
  # Set parameters 
  study_name = paste("vbsa", type, region, vbsa_study_extension, sep=".")
  vbsa_path = paste(root_design_path, vbsa_folder, sep="/")
  
  # Create filename for input settings from type, region, and study name 
  input_settings_filename = paste(study_name, "csv", sep=".")
  
  # Create filepaths for output files 
  folder_output = paste(study_name, region, type, sep=".")
  study_design_output_folder = paste(vbsa_path, study_name, sep="/")
  dir.create(study_design_output_folder)
  
  study_design_csv_filename = paste("sobol.design", region, type, study_name, "csv", sep = ".")
  study_design_csv_filepath = paste(study_design_output_folder, study_design_csv_filename, sep = "/")
  study_design_rda_filename = paste("sobol.design", region, type, study_name, "RDA", sep = ".")
  study_design_rda_filepath = paste(study_design_output_folder, study_design_rda_filename, sep = "/")
  
  # Read input settings file 
  wb <- read.csv (paste(root_design_path, vbsa_design_config_folder, input_settings_filename, sep="/"))
  
  # Convert to data table
  study.vars <- as.data.table(wb)
  
  # Compute difference between min and max 
  study.vars$delta <- study.vars$max - study.vars$min
  
  # Set factors to study.vars 
  factors <- study.vars
  factors$set <- seq (from = 1, to = nrow(factors))
  
  ###############
  # Create the sampling space for setting the factors
  # Sensitivity study in 2014 showed that N of 2000 - 4000 produced the narrowest BCI for a 19-factor model. 3000 is a conservative estiamte
  # Study size = 2N(k+1)
  k <- nrow(study.vars)   # number of factors
  
  # Generate quasi-random sequence
  print("Generating quasi-random sequence")
  print(k)
  print(N)
  qrs <- sobol(N, dim=2*k, seed=vbsa_seed)  
  
  # Separate sequence into A and B matrices, each (N x factors)
  print("Separating into A and B matrices")
  A <- qrs[,1:k]
  B <- qrs[,(k+1):(2*k)]
  
  # Create C matrices
  # For each factor, C = matrix B with column i taken from matrix A
  print("Creating C matrix")
  C.runs <- matrix(nrow=N*k,ncol=k)
  
  for(i in 1:k){
    print(i)
    C <- B
    C[,i] <- A[,i]
    C.runs[((i-1)*N+1):(i*N),] <- C
  }
  
  # Create D matrices
  # For each factor, D = matrix A with column i taken from matrix B
  print("Creating D matrix")
  D.runs <- matrix(nrow=N*k,ncol=k)
  
  for(i in 1:k){
    print(i)
    D <- A
    D[,i] <- B[,i]
    D.runs[((i-1)*N+1):(i*N),] <- D
  }
  
  # Combine matrices
  print("Combining matrices")
  runs <- rbind( A, B, C.runs, D.runs) 
  
  # Transform data; each column represents a unique Variable + Subscript 1 + Subscript 2 + Index
  #combination.  Rows represent the individual runs.
  print("Transforming data")
  a <- t(factors$set)
  b <- 1 : dim(runs)[2]
  print("Generating z matrix")
  z <- matrix(a, nrow=length(b), ncol=length(a), byrow=TRUE)
  print("Generating zz matrix")
  zz <- apply(b == z, c(1,2), function(x) {if (x) 1 else 0})
  print("Generating w matrix")
  w <- runs %*% zz
  
  # Take result and put into model format
  print("Creating new design")
  new.design <- w * matrix(factors$delta, nrow=dim(runs)[1], ncol=length(a), byrow=TRUE) + matrix(factors$min, nrow=dim(runs)[1], ncol=length(a), byrow=TRUE)
  
  print("Formatting new design")
  new.design <- as.data.table (melt (t(new.design)))
  
  setnames (new.design, c("variable", "run", "value"))
  
  vbsa.design <- data.table (variable = factors$factor,
                                        run = new.design$run, value = new.design$value)
  
  print("Saving design")
  save (vbsa.design, file = study_design_rda_filepath)

  #sanity checks on design
  max (vbsa.design$run)
  head (vbsa.design)
  tail (vbsa.design)
  
  #sanity.test <- dcast (design.in.model.format, run ~ variable)
  #summary (sanity.test)
}






