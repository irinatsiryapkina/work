# Sort EE results and save to csv file for informing VBSA study design 
# D.Inman and A.Eberle
# 18 Jan 2018  

sort.ee.results <- function(region, ee_study_name, config_file) {
  
  # Source R script config file and define variables from file 
  source(config_file)
  define.variables()
  
  # Set parameters 
  setwd (ee_working_directory)
  ee_results_path = paste(root_data_path, "ee", ee_study_name, ee_results_folder, sep="/")
  vbsa_folder = paste(root_data_path, "ee", ee_study_name, for_vbsa_folder, sep="/")
  dir.create(paste(ee_results_path, ee_study_name, sep="/"))
  dir.create(vbsa_folder)
  dir.create(ee_results_path)
  
  # Load libraries 
  library (dplyr)
  library (data.table)
  
  for (type in type_list){
    sig_factor_filename = paste("sig.ee.results", region, type, ee_study_name, "RDA", sep=".")
    sig_factor_filepath = paste(ee_results_path, sig_factor_filename, sep="/")
    
    output_rda_filename = paste(region, type, ee_study_name, "sig.factors.RDA", sep=".")
    output_rda_filepath = paste(ee_results_path, output_rda_filename, sep="/")
    
    output_vbsa_filename = paste(region, "total", type, ee_study_name, "sig.factors.csv", sep=".")
    output_vbsa_filepath = paste(vbsa_folder, output_vbsa_filename, sep="/")
    
    load (sig_factor_filepath)
    
    factors <- sig.factors
    
    ee.total.sig.factors.2040 <- setorder (factors, mu.star)
    
    if (type == "sludge"){
      type_name = "WWTP"
    }
    
    if (type == "biogas"){
      type_name = type
    }
    
    save (ee.total.sig.factors.2040, 
          file = output_rda_filepath)
    
    write.csv (ee.total.sig.factors.2040, file = output_vbsa_filepath) 
  }
}
