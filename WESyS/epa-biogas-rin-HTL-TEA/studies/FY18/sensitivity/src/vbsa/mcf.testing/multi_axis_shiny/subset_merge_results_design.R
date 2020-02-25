rm(list=ls())
R_LIBS = ("/home/R/library") # set path for R libraries 
options(scipen=999) # turn scientific notation off
library(dplyr)

region_list <- list("joined")

list_filter_results <- list("HTL", "CHP", "CNG", "PNG", "Elec", "NoWTE") #list("HTL", "CHP", "CNG", "PNG", "Elec", "NoWTE")
vbsa_design_root <- "~/Box Sync/WESyS_Project/Study_Designs/FY19/vbsa_design"
study_extension <- "q1_12factors_31oct"
#results_folder <- "~/Documents/WTE/WESyS data tableau"
save_folder <- "~/Box Sync/WESyS_Project/data_wte/vbsa"

for (region in region_list){
  # set parameters 
  region <- region
  type <- "all"
  total_energy_name <- paste(type, "total energy", sep=".")
  
  # load sampled results
  filename_results <- paste(tolower(region), type, "1pct", sep="_")
  filename_results <- paste(filename_results, "csv", sep=".")
  results_folder <- paste(save_folder, tolower(region), type, study_extension, "results", sep="/")
  file_results <- paste(results_folder, filename_results, sep="/")
  print("Loading results...")
  out <- data.table::fread (file_results)
  
  # load study design 
  filename <- paste("sobol.design", tolower(region), type, "vbsa", type, tolower(region), study_extension, "RDA", sep=".")
  folder <- paste("vbsa", type, tolower(region), study_extension, sep=".")
  filepath <- paste(vbsa_design_root, folder, filename, sep="/")
  print("Loading study design...")
  load(filepath)
  
  # filter results for values of interest
  
  #load ("../data/wesys.htl.2040.RDA")
  #setnames (htl.out, c("run_id", "factor", "value"))
  

  
  print("Filtering results...")
  
  #select only HTL outputs
  output.factors <- as.data.table (unique (out$factor))
  prod.factors <- output.factors [output.factors$V1 %like% "pro", ] #dplr wrapper for grep
  htl.factors <- prod.factors [prod.factors$V1 %like% "HTL", ]
  total.factors <- prod.factors [prod.factors$V1 %like% "total energy", ]
  other_factors <- output.factors[1159:1160]
  totalandhtl <- unique(rbind(htl.factors, total.factors, other_factors))
  selected <- subset (out, output_data$factor %in% totalandhtl$V1)
  #selected <- out[-grep("potential", out$factor), ]
  #selected <- selected[-grep("Run", selected$factor), ]
  #selected <- filter(selected, grepl(paste(list_filter_results, collapse="|"), factor))
  
  # # select only energy and aggregate to get total
  # energy <- selected[grep("tot", selected$factor), ]
  # energy.tot <- aggregate(energy$value, 
  #                         by=list(run_id=energy$run_id, 
  #                                 time=energy$time, 
  #                                 source=energy$source,
  #                                 run_config=energy$run_config
  #                         ), 
  #                         FUN=sum)
  # 
  # # add columns to total energy to create the same structure as results 
  # energy.tot$gid <- NA
  # energy.tot$factor <- total_energy_name
  # colnames(energy.tot)[colnames(energy.tot) == 'x'] <- 'value'
  
  # add total energy to filtered results 
  energy.wtot <- selected #rbind(selected, energy.tot)
  
  # rename columns 
  colnames(energy.wtot)[which(names(energy.wtot) == "factor")] <- "type_energy"
  colnames(vbsa.design)[which(names(vbsa.design) == "variable")] <- "factor"
  colnames(vbsa.design)[which(names(vbsa.design) == "run")] <- "run_id"
  colnames(vbsa.design)[which(names(vbsa.design) == "value")] <- "value.factor"
  
  # filter study design based on selected runs 
  print("Filtering design...")
  filtered_design <- filter(vbsa.design, vbsa.design$run_id %in% unique(out$run_id))
  
  # merge filtered results with study design 
  #print("Merging data...")
  #out_filtered <- merge(energy.wtot, filtered_design, by="run_id")
  #length(unique(out_filtered$run_id))
  
  # save results
  print("Saving results...")
  filename_output <- paste("sampled_design", tolower(region), type, study_extension, "csv", sep=".")
  filepath <- paste(save_folder, tolower(region), type, study_extension, "results", filename_output, sep="/")
  save(vbsa.design=filtered_design, file=filepath)

  filename_output <- paste("sampled_results", tolower(region), type, study_extension, "RDA", sep=".")
  filepath <- paste(save_folder, tolower(region), type, study_extension, "results", filename_output, sep="/")
  save(energy.wtot, file=filepath)
  
  # print("Merging design with 2040 results")
  # energy.wtot.2040 <- energy.wtot[grep(2040, energy.wtot$time), ]
  # out_filtered <- merge(energy.wtot.2040, filtered_design, by="run_id")
  # length(unique(out_filtered$run_id))
  # 
  # print("Saving merged results")
  # filename_output <- paste("design_output", tolower(region), type, "2040", study_extension, sep="_")
  # filename_output <- paste(filename_output, "csv", sep=".")
  # filepath <- paste(save_folder, tolower(region), type, study_extension, "results", filename_output, sep="/")
  # write.csv(out_filtered, file=filepath)
}
  