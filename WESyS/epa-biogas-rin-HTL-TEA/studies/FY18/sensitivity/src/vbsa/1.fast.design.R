# Create FAST Study 
# D.Inman and A.Eberle
# 5 Apr 2018  

design.fast.study <- function(region, type, vbsa_study_extension, config_file) {
  print(region)
  print(type)
  
  # Source R script config file and define variables from file 
  source(config_file)
  define.variables()
  
  # Set parameters 
  study_name = paste("fast", type, region, vbsa_study_extension, sep=".")
  vbsa_path = paste(root_design_path, vbsa_folder, sep="/")
  
  # Create filename for input settings from type, region, and study name 
  input_settings_filename = paste(study_name, "csv", sep=".")
  
  # Create filepaths for output files 
  folder_output = paste(study_name, region, type, sep=".")
  study_design_output_folder = paste(vbsa_path, study_name, sep="/")
  dir.create(study_design_output_folder)
  
  study_design_csv_filename = paste("fast.design", region, type, study_name, "csv", sep = ".")
  study_design_csv_filepath = paste(study_design_output_folder, study_design_csv_filename, sep = "/")
  study_design_rda_filename = paste("fast.design", region, type, study_name, "RDA", sep = ".")
  study_design_rda_filepath = paste(study_design_output_folder, study_design_rda_filename, sep = "/")
  
  # Read input settings file 
  wb <- read.csv (paste(root_design_path, vbsa_design_config_folder, input_settings_filename, sep="/"))
  
  # Convert to data table
  study.vars <- as.data.table(wb)
  
  # Set factors to study.vars 
  factors <- study.vars
  factors$set <- seq (from = 1, to = nrow(factors))
  
  ###############
  # Create the sampling space for setting the factors
  # Sensitivity study in 2014 showed that N of 2000 - 4000 produced the narrowest BCI for a 19-factor model. 3000 is a conservative estiamte
  # Study size = 2N(k+1)
  k <- nrow(study.vars)   # number of factors
  
  study.min <- study.vars$min
  study.max <- study.vars$max
  var.names <- study.vars$factor
  fast.design <- fast_parameters (study.min, study.max, names = paste (var.names))
  temp <- as.data.table (fast.design)
  temp$run <- as.factor (seq (from = 1, to = nrow(fast.design), by = 1))
  fast.design <- melt (temp)
  fast.design <- fast.design[order(run)]
  fast.design$run <- as.integer(fast.design$run)
  
  print("Saving design")
  save (fast.design, file = study_design_rda_filepath)

  #sanity checks on design
  print(max(fast.design$run))
  print(head(fast.design))
  print(tail(fast.design))
  
  #sanity.test <- dcast (design.in.model.format, run ~ variable)
  #summary (sanity.test)
}






