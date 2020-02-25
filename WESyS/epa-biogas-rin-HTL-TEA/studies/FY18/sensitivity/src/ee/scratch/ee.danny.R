#D. Inman
#11.21.2017
#EE analysis

rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)

# Set parameters 
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")
#setwd ("~/ws/src/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")
study_design_folder = "~/Box Sync/WESyS Project/Study_Designs/FY18"
local_rda_folder = "~/data_wte"
figures_filepath = "figures"
design_filepath = "designs"
dir.create (local_rda_folder)
type_list = list("biogas")#"sludge", "biogas")
region_list = list("rotus")#"ca", "rotus")
study_name = "2000traj_dec"
rda_results_folder = "~/Box Sync/WESyS Project/RDA_result_files"
r <- 2000

# Load libraries
library (dplyr)
library (data.table)
library (sensitivity)
library (randtoolbox)
library (gdata)
library (plyr)

#functions
batch.ee <- function (x,y,n,r){
  result <- ee (x,y,n,r)
  return (result)
}

source ("sens.functions.R")

for (region in region_list){ 
  print(region)
  
  # Generate EE design config name 
  ee_design_config_filename = paste(region, "ee.study.design.config.csv", sep=".")
  ee_design_config_filepath = paste(design_filepath, ee_design_config_filename, sep="/")
  
  # Load study config file
  vars <- read.csv(ee_design_config_filepath)
  vars <- vars[,1:5]
  
  # Load Morris Model Design Generated
  sa_filename = paste("sa.design", region, "test.RDA", sep=".")
  sa_design_filepath = paste(study_design_folder, sa_filename, sep="/")
  load(sa_design_filepath)
  
  N <- nrow (vars)
  
  # Load the Output from the Model Run
  #results_rda_filename = paste("ee", region, "wesys.results.RDA", sep=".")
  #results_rda_filepath = paste(rda_results_folder, study_name, results_rda_filename, sep="/")
  #load (results_rda_filepath)
  load ("data_wte/ee.rotus.2000traj_dec.wesys.results.RDA")
  
  out <- setorder (out, factor) #arrange by factor
  out <- subset (out, time == 2040) #just selct 2040 for analysis
  out <- out [, ("time"):=NULL] #drop the time column now that only 2040 has been selected
  
  # Loop through types of feedstock (e.g., sludge, biogas)
  for (type in type_list){ 
    print(type)

    output_type_filename = paste("ee.results", region, type, "RDA", sep=".")
    output_type_filepath = paste(local_rda_folder, output_type_filename, sep="/")
  
    output_sig_type_filename = paste("sig.ee.results", region, type, "RDA", sep=".")
    output_sig_type_filepath = paste(local_rda_folder, output_sig_type_filename, sep="/")

    output_figure_filename = paste(region, type, sep=".")
    output_figure_filepath = paste(figures_filepath, output_figure_filename, sep="/")
    output_figure_filepath = paste(output_figure_filepath, "/", sep="")
    
    #output_biogas_filepath = "~/data_wte/ee.results.rotus.bio.test.RDA"
    #output_sig_biogas_filepath = "~/data_wte/sig.ee.results.rotus.biogas.test.RDA"
    #figure_biogas_filepath = "figures/rotus.biogas/"
    
    if (type == "sludge"){
      #select the WWTP - sludge specific data
      data.2040 <- out [grep ("WWTP", out$factor), ] 
      data.2040 <- data.2040 [!grep ("FT", data.2040$factor), ]
      data.2040 <- data.2040 [!grep ("Fuel", data.2040$factor), ]
      data.2040 <- data.2040 [grep ("tot", data.2040$factor), ] #just the total production
      
      #create a total production datatable
      df <- data.2040
      total.prod <- aggregate (df$value, by = list(Category = df$run_id), FUN = sum)
      total.prod <- data.table (run_id = df$run_id, factor = "WWTP.total", value = total.prod$x)
      data.2040 <- rbind (df, total.prod)
      
      if (region == "ca"){
        max_val = 3.9e-2
      }
      
      if (region == "rotus"){
        max_val = 0.17
      }
      y_max = 8e5
    }
   
    if (type == "biogas"){
      #select the biogas runs
      data.2040 <- out [!grep ("HTL", out$factor), ]
      data.2040 <- data.2040 [!grep ("FT", data.2040$factor), ]
      data.2040 <- data.2040 [!grep ("Fuel", data.2040$factor), ]
      data.2040 <- data.2040 [grep ("tot", data.2040$factor), ] #just the total production
      
      #create a total production datatable
      df <- data.2040
      total.prod <- aggregate (df$value, by = list(Category = df$run_id), FUN = sum)
      total.prod <- data.table (run_id = df$run_id, factor = "biogas.total", value = total.prod$x)
      data.2040 <- rbind (df, total.prod)
    
      if (region == "ca"){
        max_val = 3.5e-1
      }
      
      if (region == "rotus"){
        max_val = 1.36
      }
      
      y_max = 8e5
    }
    
    # Generate output RDA filename 
    output_rda_filename = paste(region, type, "2040.RDA", sep=".")
    output_rda_filepath = paste(local_rda_folder, output_rda_filename, sep="/") 
    
    # Save results 
    save (data.2040, file = output_rda_filepath)
    
    # Run EE for sludge
    dat <- data.2040
    
    dat.split <- split (dat, dat$factor) #create a list of datatables by factor
    
    LIST <- list ()
    for (i in 1:length (dat.split)){
      print(i)
      LIST [[i]] <- batch.ee (SA.design, dat.split[[i]]$value, N, r)
      LIST [[i]] <- join (vars, LIST[[i]], by="set")
      LIST [[i]] <- arrange (LIST[[i]], desc(std.errors))
      ee.results <- (LIST)
    }
    
    names (ee.results) <- names (dat.split)
    save (ee.results, file = output_type_filepath)
    
    sig.factors <- lapply (ee.results, function (x) subset (x, std.errors < 2))
    save (sig.factors, file = output_sig_type_filepath)
    
    #plot histograms of each output
    dir.create (output_figure_filepath)
    output_filename_fig = paste(region, type, "pdf", sep=".")
    pdf (file = paste(output_figure_filepath, output_filename_fig)) #names (dat.split [j]), ".png"))
    par(mfrow=c(6, 3))
    par(mar=c(4, 4, 1.2, 1.2))

    quad <- 9.47086 * 10^-10 #conversion factor

    for (j in 1:length (dat.split)) {
      print(j)
      hist (dat.split[[j]]$value*quad, main = "", #paste (names (dat.split[j])),
            xlab = paste(names(dat.split [j]), "(quads)"), ylab = "Frequency", ylim=c(0, y_max), 
            xlim=c(0, max_val), breaks=c(0:40)*max_val/40, las = 0)#breaks=10,cex.lab=1, cex.main=0.9,  
    }
    dev.off()
    
  }
}

