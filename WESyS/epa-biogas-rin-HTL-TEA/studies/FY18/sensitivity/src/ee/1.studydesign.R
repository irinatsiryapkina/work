# Design elementary effects study based on Morris OAT
# D.Inman and A.Eberle
# 18 Jan 2018  

design.ee.study <- function(region, ee_study_name, config_file) { 

  # Load libraries 
  library(sensitivity)
  library(gdata)
  library (dplyr)
  library (data.table)
  
  # Source R script config file and define variables from file 
  source(config_file)
  define.variables()
    
  # Set parameters for each study  
  setwd(ee_working_directory)
  study_design_path = paste(root_design_path, sa_design_folder, sep="/")
  study_design_extension = paste("ee", ee_study_name, "csv", sep=".")
  dir.create(study_design_path)
  dir.create(paste(study_design_path, ee_study_name, sep="/"))
  design_filepath = paste(root_design_path, ee_design_config_folder, sep="/")
  dir.create(design_filepath)
  
  # Generate filenames and paths 
  print(region)

  results_rda_filename = paste("ee.design", region, ee_study_name, "RDA", sep=".")
  results_rda_filepath = paste(study_design_path, ee_study_name, results_rda_filename, sep="/") 
  
  sa_design_filename = paste("sa.design", region, ee_study_name, "RDA", sep=".")
  sa_design_filepath = paste(study_design_path, ee_study_name, sa_design_filename, sep="/") 
  
  study_design_filename = paste(region, study_design_extension, sep=".")
  study_design_filepath = paste(design_filepath, study_design_filename, sep="/")

  ## 1. Load Excel Input
  vars <- read.csv(study_design_filepath)
  #read.xls(study_design_filename)
  #vars <- vars[,1:5]
  
  vars <- mutate(vars, new.var.names = paste(factor, sep=":"))
  vars$delta <- vars$max - vars$min
  
  ## 2. Generate a Study Design
  set.seed(ee_seed)
  
  # Morris 2r sample points per input:
  #     total = r(k + 1) samples, where
  #        k = the number of inputs
  #        r = the number of trajectories (reps)
  #        N = number of factors
  N <- nrow(vars)
  
  myGenerate <- function (X){
    rep(1,dim(X)[2])
  }
  # Generate the Morris Study Design
  print("Generating SA design")
  SA.design <- morris(model = myGenerate, factors = N, r = r,
                      design = list(type = "oat", levels = 6, grid.jump=1, scale = FALSE))$X
  
  # Save the Morris Study Design
  print("Saving SA design")
  save(SA.design, file = sa_design_filepath)
  
  # 3. Transform Data
  #         Each column represents a unique Variable
  #         Rows represent the individual runs.
  print("Generating EE design")
  a <- t(vars$set)
  b <- 1 : dim(SA.design)[2]
  z <- matrix(a, nrow=length(b), ncol=length(a), byrow=TRUE)
  zz <- apply(b == z, c(1,2), function(x) {if (x) 1 else 0})
  w <- SA.design %*% zz
  
  new.design <- w * matrix(vars$delta, nrow=dim(SA.design)[1], ncol=length(a), byrow=TRUE) + matrix(vars$min, nrow=dim(SA.design)[1], ncol=length(a), byrow=TRUE)
  colnames(new.design) <- vars$new.var.names
  ee.design <- melt(t(new.design))
  colnames(ee.design) <- c("variable", "run", "value")
  
  ## 4. Save Transformed Outputs
  #       # These outputs are inputs for the WESyS model
  print("Saving EE design")
  save (ee.design, file = results_rda_filepath)
}
