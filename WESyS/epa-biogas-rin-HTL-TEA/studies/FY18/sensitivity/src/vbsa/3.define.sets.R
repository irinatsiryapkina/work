# Define sets for VBSA Study 
# D.Inman and A.Eberle
# 18 Jan 2018  

#load model output - timeseries
define.sets <- function(vbsa_wesys_result_file, type_list) { 
  # Source R script config file and define variables from file 
  source(config_file)
  define.variables()
  
  # Load libraries 
  library(dplyr)
  library(data.table)
  
  # Define functions 
  # Function to select the metrics of interest for the VBSA
  select.metrics <- function (df, factors, i, data_folder) {{
    temp <- subset (df, factor == factors [[1]][i])
    filename = paste(factors [[1]][i], "RDA", sep = ".")
    save (temp, file = paste (data_folder, filename, sep="/"))}
  }
  
  # Set parameters 
  setwd(vbsa_working_directory)
  
  # Load data 
  print("Loading WESyS results file")
  load(vbsa_wesys_result_file)
  
  # Select unique factors 
  print("Selecting metrics of interest for VBSA")
  vbls <- as.data.table(unique(out$factor))
  vbls$factor <- as.character(vbls$V1)
  out <- subset (out, time == 2040) #just selct 2040 for analysis
  out <- out [, ("time"):=NULL] #drop the time column now that only 2040 has been selected
  
  if (type == "sludge") {
    vbls <- vbls[grep ("WWTP", vbls$factor), ] 
    vbls <- vbls[grep ("tot", vbls$factor), ] 
    #vbls <- vbls[!grep ("FT", vbls$factor), ] 
    #vbls <- vbls[!grep ("Fuel", vbls$factor), ] 
    vbls <- vbls[!grep ("potential", vbls$factor), ] 
    vbls <- vbls[!grep ("total", vbls$factor), ] 
    
    out <- subset(out, out$factor %in% vbls$factor)
    out$value <- as.integer(out$value)
    
    #create a total production datatable
    df <- unique(out)
    total.prod <- df[, sum(value), by=run_id]
    total.prod <- data.table(run_id = total.prod$run_id, factor = "WWTP.total energy", value = total.prod$V1)
    data.2040 <- rbind (df, total.prod)
  }
  
  if (type == "biogas") {
    #vbls <- vbls [!grep ("HTL", vbls$factor), ]
    #vbls <- vbls [!grep ("FT", vbls$factor), ]
    #vbls <- vbls [!grep ("Fuel", vbls$factor), ]
    vbls <- vbls [!grep ("potential", vbls$factor), ] #just the total production for each individual pathway
    vbls <- vbls [grep ("tot", vbls$factor), ] #just the total production
    
    out <- subset(out, out$factor %in% vbls$factor)
    out$value <- as.integer(out$value)
    
    vbls <- vbls[!grep ("total", vbls$factor), ] 
    
    # create selection for wwtp total 
    vbls_wwtp <- vbls[grep ("WWTP", vbls$factor), ] 
    out_wwtp <- subset(out, out$factor %in% vbls_wwtp$factor)
    out_wwtp$value <- as.integer(out_wwtp$value)
    
    #create a total production datatable for wwtp 
    total.prod.wwtp <- out_wwtp[, sum(value), by=run_id]
    total.prod.wwtp <- data.table(run_id = total.prod.wwtp$run_id, factor = "WWTP.total energy", value = total.prod.wwtp$V1)
    
    #create a total production datatable
    vbls2 <- vbls [!grep ("total", vbls$factor), ] #just the total production for each individual pathway
    out2 <- subset(out, out$factor %in% vbls2$factor)
    out2$value <- as.integer(out2$value)
    
    total.prod <- out2[, sum(value), by=run_id]
    total.prod <- data.table(run_id = total.prod$run_id, factor = "biogas.total", value = total.prod$V1)
    data.2040 <- rbind (out, total.prod)
    data.2040 <- rbind (data.2040, total.prod.wwtp)
    
    #create a datatables by tech type 
    tech_list = list('CNG', 'PNG', 'HTL', 'CHP', 'Elec')
    for (tech in tech_list) {
      selection <- vbls [grep (tech, vbls$factor), ] #just the total production for each individual pathway
      out3 <- subset(out, out$factor %in% selection$factor)
      out3$value <- as.integer(out3$value)
      
      total.prod.tech <- out3[, sum(value), by=run_id]
      factor_name <- paste(tech, 'total', sep='.')
      total.prod.tech <- data.table(run_id = total.prod.tech$run_id, factor = factor_name, value = total.prod.tech$V1)
      data.2040 <- rbind (data.2040, total.prod.tech)
      
    }
    
  }
  
  if (type == "all"){
    data.2040 <- subset(out, out$factor %in% type_list)
    data.2040$value <- as.integer(out$value)
  }
  
  vbls <- as.data.table(unique(data.2040$factor))
  vbls$factor <- as.character(vbls$V1)
  
  # Set order of outputs 
  setorder(data.2040, "factor", "run_id")
  
  # Confirm unique outputs selected
  data.2040 <- unique(data.2040)
  
  # Create output path 
  data_folder = paste(root_data_path, "vbsa", region, type, vbsa_study_extension, "vbsa_sets", sep="/")
  dir.create(paste(root_data_path, "vbsa", sep="/"))
  dir.create(paste(root_data_path, "vbsa", region, sep="/"))
  dir.create(paste(root_data_path, "vbsa", region, type, sep="/"))
  dir.create(paste(root_data_path, "vbsa", region, type, vbsa_study_extension, sep="/"))
  dir.create(data_folder)
  
  # Create data files 
  LIST <- list()
  print("Selecting data for metrics of interest")
  for (i in 1: nrow (vbls)){
    LIST[[i]] <- select.metrics (data.2040, vbls, i, data_folder)
    data.list <- list.files (path = data_folder, full.names = TRUE, include.dirs = TRUE)
  }
  
  # Save data 
  print("Saving data")
  file_path = paste(data_folder, "vbsa.input.RDA", sep="/")
  save (data.list, file=file_path)
}
