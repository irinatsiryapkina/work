# Pull VBSA study results from database for analysis
# D.Inman and A.Eberle
# 18 Jan 2018  

get.data <- function(region, type, vbsa_study_extension, run_config_num, config_file, output_filepath) {
  
  # Load libraries 
  library (dplyr)
  library (RPostgreSQL)
  library (dbplyr)
  library (data.table)
  
  # Source R script config file and define variables from file 
  source(config_file)
  define.variables()
  
  # Set parameters
  setwd (vbsa_working_directory)
  dir.create(root_data_path)
  dir.create(paste(root_data_path, "vbsa", sep="/"))
  wesys_results_path = paste(root_data_path, "vbsa", region, type, vbsa_study_extension, wesys_results_folder, sep="/")
  dir.create(paste(root_data_path, "vbsa", region, sep="/"))
  dir.create(paste(root_data_path, "vbsa", region, type, sep="/"))
  dir.create(paste(root_data_path, "vbsa", region, type, vbsa_study_extension, sep="/"))
  dir.create(wesys_results_path)
  
  # Connect to database 
  con <- DBI::dbConnect (RPostgreSQL::PostgreSQL(),
                         host = host,
                         dbname = dbname,
                         user = username,
                         #password = pwd
                         password = rstudioapi::askForPassword("Database password")
  )
  
  print(region)
  print(type)
  
  # Create string for SQL selection 
  q1 <- ('SELECT "run_id", "factor", "time", "value" FROM "sensitivity_runs"."output_table" WHERE "time" = 2040 AND "source" = \'output_fy19q4\' AND "run_config" = ')
  q2 <- paste(q1, run_config_num, sep = "")
  
  # Execute SQL and save results 
  outputs <- tbl(con, sql(q2))
  print("Collecting results from database using the following query:")
  print(q2)
  out <- collect (outputs, n = Inf)
  out <- as.data.table (out)
  save (out, file = output_filepath)
  
  rm (out, outputs)
  
  dbDisconnect(con)
}
