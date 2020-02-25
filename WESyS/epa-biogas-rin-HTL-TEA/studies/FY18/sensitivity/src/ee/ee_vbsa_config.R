define.variables <- function() {
  # File path to R libraries 
  r_library_path <<- "/home/R/library"
  
  # File paths to working directories for EE and VBSA (this is where the R code is stored)
  ee_working_directory <<- "~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee"
  vbsa_working_directory <<- "~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa"
  
  # File paths to folders for study designs and data 
  root_design_path <<- "~/Box Sync/WESyS_Project/Study_Designs/FY19"
  root_data_path <<- "~/Box Sync/WESyS_Project/data_wte"  # results generated from SA analysis 
  
  # Names of studies 
  ee_study_extension <<- "q1_12factors_31oct"  # name of ee study 
  vbsa_study_extension <<- "q1_12factors_31oct" #"9aug2018"#"fixedfactornew.rin"#"bugfix.17may"  # name of vbsa study (ca_biogas = 20jan; ca_sludge = 12jan; rotus_biogas = 6feb; rotus_sludge = 5feb) test_3dummy_500traj
  
  # Lists of regions and types of waste to be analyzed 
  region_list <<- list("joined")  # list of region names to be analyzed 
  type_list <<- list("all")  # list of types of waste to be analyzed
  
  # Constants 
  quad <<- 9.47086 * 10^-10  # conversion factor: number of quads per GJ 
  r <<- 25  # number of trajectories for EE study 
  ee_seed <<- 12340  # seed for EE study design 
  N <<- 7500 #500  # number of observations for VBSA design (7500 should be conservative for 50 factor study) 
  vbsa_seed <<- 31001 # see for VBSA study design 
  
  # Folder names 
  ee_design_config_folder <<- "ee_design_configs"  # folder name for EE design configs
  vbsa_design_config_folder <<- "vbsa_design_configs"  # folder name for VBSA design configs 
  sa_design_folder <<- "ee_sa_design"  # folder name for EE study designs created in R 
  wesys_results_folder <<- "wesys_results"  # folder name for WESyS results pulled from database 
  ee_results_folder <<- "ee_results"  # folder name for EE results calculated in R 
  figures_folder <<- "figures"  # folder name for figures generated in R 
  for_vbsa_folder <<- "for.vbsa"  # folder name for csv files generated from EE study for VBSA
  vbsa_folder <<- "vbsa_design"  # folder name for VBSA study designs created in R 
  
  # Database information 
  run_config_list <<- list(6)  # list of run_configs to be collected from database 
  username <<- "aeberle"  # db username 
  host <<- "walter"  # db host
  dbname <<- "wte"  # db name 
}
