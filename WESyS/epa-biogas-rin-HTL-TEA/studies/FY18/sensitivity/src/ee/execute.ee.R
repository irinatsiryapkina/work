rm(list=ls())
R_LIBS = ("/home/R/library") # set path for R libraries 
options(scipen=999) # turn scientific notation off
options(stringsAsFactors = FALSE) # turn off representing strings as factors

# Source R script config file and define variables from file 
config_file = "~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/ee_vbsa_config.R"
source(config_file)
define.variables()

# Set working directory for EE and source EE scripts 
setwd(ee_working_directory)
source(paste(ee_working_directory, "1.studydesign.R", sep="/"))
source(paste(ee_working_directory, "2.get.data.R", sep="/"))
source(paste(ee_working_directory, "3.ee.R", sep="/"))
source(paste(ee_working_directory, "4.sort.results.R", sep="/"))
ee_run_config_num <- 0055 # 8 = ca sludge vbsa; 9 = ca biogas vbsa; 6 = rotus ee; 7 = ca ee  

for (region in region_list){
  
  # Design EE study
  #design.ee.study(region, ee_study_extension, config_file)
  
  # # Get WESyS simulation results from database 
  output_filename = paste("ee", ee_study_extension, "wesys.results.RDA", sep=".")
  output_filepath = paste(root_data_path, "ee", ee_study_extension, wesys_results_folder, output_filename, sep="/")
  get.data(region, ee_study_extension, ee_run_config_num, config_file, output_filepath)
  # 
  # # Run EE script to evaluate influential factors 
  run.ee(region, ee_study_extension, config_file, 0.9)
  # 
  # # Sort influential factors and save data for VBSA study 
  sort.ee.results(region, ee_study_extension, config_file)
  
}
