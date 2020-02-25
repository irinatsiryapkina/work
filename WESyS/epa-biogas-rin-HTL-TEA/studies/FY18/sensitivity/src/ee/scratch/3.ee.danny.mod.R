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
study_design_folder = "~/Box Sync/WESyS Project/Study_Designs/FY18/sa_design"
local_rda_folder = "/data_wte"
dir.create (local_rda_folder)
design_filepath = "designs"

type_list = list("sludge", "biogas")
region_list = list("ca")#("ca", "rotus")
study_name = "2000traj"
rda_results_folder = "~/Box Sync/WESyS Project/RDA_result_files"
r <- 2000
quad <- 9.47086 * 10^-10 #conversion factor


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

region = "rotus"

#for (region in region_list){ 
  #print(region)
  
  # Generate EE design config name 
  #ee_design_config_filename = paste(region, study_name, "ee.study.design.xlsx", sep=".")
  ee_design_config_filename = paste(region, study_name, "ee.study.design.csv", sep=".")
  ee_design_config_filepath = paste(design_filepath, ee_design_config_filename, sep="/")
  
  # Load study config file
  #vars <- read.xls(ee_design_config_filepath, header = TRUE)
  vars <- read.csv(ee_design_config_filepath, header = TRUE)
  vars <- vars[,1:5]
  
  # Load Morris Model Design Generated
  sa_filename = paste("sa.design", region, study_name, "RDA", sep=".")
  sa_design_filepath = paste(study_design_folder, sa_filename, sep="/")
  load(sa_design_filepath)
  
  N <- nrow (vars)
  
  # Load the Output from the Model Run
  results_rda_filename = paste("ee", region, study_name, "wesys.results.RDA", sep=".")
  results_rda_filepath = paste(rda_results_folder, study_name, results_rda_filename, sep="/")
  load (results_rda_filepath)
  
  out <- setorder (out, factor) #arrange by factor
  out <- subset (out, time == 2040) #just selct 2040 for analysis
  out <- out [, ("time"):=NULL] #drop the time column now that only 2040 has been selected
  
  # Loop through types of feedstock (e.g., sludge, biogas)
  type = "sludge"
  #type = "biogas"
  
  #for (type in type_list){ 
    #print(type)

    output_type_filename = paste("ee.results", region, type, study_name, "RDA", sep=".")
    output_type_filepath = paste(local_rda_folder, output_type_filename, sep="/")
  
    output_sig_type_filename = paste("sig.ee.results", region, type, study_name, "RDA", sep=".")
    output_sig_type_filepath = paste(local_rda_folder, output_sig_type_filename, sep="/")

    output_figure_filename = paste(region, type, sep=".")
    output_figure_filepath = paste(figures_filepath, output_figure_filename, sep="/")
    output_figure_filepath = paste(output_figure_filepath, "/", sep="")
    
    #if (type == "sludge"){
      #select the WWTP - sludge specific data
      data.2040 <- out [grep ("WWTP", out$factor), ] 
      data.2040 <- data.2040 [!grep ("FT", data.2040$factor), ]
      data.2040 <- data.2040 [!grep ("Fuel", data.2040$factor), ]
      data.2040 <- data.2040 [!grep ("total", data.2040$factor), ] #just the total production for each individual pathway
      data.2040 <- data.2040 [grep ("tot", data.2040$factor), ] #just the total production
      data.2040$value <- as.integer(data.2040$value)
      
      #create a total production datatable
      df <- unique(data.2040)
      total.prod <- df[, sum(value), by=run_id]
      total.prod <- data.table (run_id = total.prod$run_id, factor = "WWTP.total", value = total.prod$V1)
      data.2040 <- rbind (df, total.prod)
      #max_val = max(df$value*quad)
      
      
    #if (type == "biogas"){
      #select the biogas runs
      data.2040 <- out [!grep ("HTL", out$factor), ]
      data.2040 <- data.2040 [!grep ("FT", data.2040$factor), ]
      data.2040 <- data.2040 [!grep ("Fuel", data.2040$factor), ]
      data.2040 <- data.2040 [!grep ("total", data.2040$factor), ] #just the total production for each individual pathway
      data.2040 <- data.2040 [grep ("tot", data.2040$factor), ] #just the total production
      data.2040$value <- as.integer(data.2040$value)

      #create a total production datatable
      df <- unique(data.2040)
      total.prod <- df[, sum(value), by=run_id]
      total.prod <- data.table (run_id = total.prod$run_id, factor = "biogas.total", value = total.prod$V1)
      data.2040 <- rbind (df, total.prod)
      max_val = max(df$value*quad)
      
      
    # Generate output RDA filename 
    output_rda_filename = paste(region, type, study_name, "2040.RDA", sep=".")
    output_rda_filepath = paste(local_rda_folder, output_rda_filename, sep="/") 
    
    # Save results 
    save (data.2040, file = output_rda_filepath)

    # Run EE 
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
    names_plots <- names(dat.split)
    
    if (type == "sludge"){
      typetot = "WWTP"
    }
    if (type == "biogas"){
      typetot = type 
    }
    
    total <- paste(typetot, "total", sep=".")
    name_tot <- c(total)
    names_except_tot <- names_plots[which(!names_plots%in%name_tot)]

    dir.create (output_figure_filepath)
    output_filename_fig = paste("histograms", region, type, study_name, "uniformxcale.pdf", sep=".")
    pdf (file = paste(output_figure_filepath, output_filename_fig)) 
    par(mfrow=c(6, 3))
    par(mar=c(4, 4, 1.2, 1.2))

    for (j in names_except_tot) {
      print(j)
      hist (dat.split[[j]]$value*quad, main = "", 
            xlab = paste(names(dat.split [j]), "(quads)"), ylab = "Frequency",
            xlim=c(0, max_val_xaxis), breaks=c(c(0:40)*max_val/40),
            las = 0, height = 11, width = 8.5) 
    }
    dev.off()
    
    output_filename_fig = paste("histograms", region, type, study_name, "raw.pdf", sep=".")
    pdf (file = paste(output_figure_filepath, output_filename_fig)) 
    par(mfrow=c(6, 3))
    par(mar=c(4, 4, 1.2, 1.2))
    
    for (j in names_except_tot) {
      print(j)
      hist (dat.split[[j]]$value*quad, main = "", 
            xlab = paste(names(dat.split [j]), "(quads)"), ylab = "Frequency", las = 0)  
    }
    dev.off()
    
    output_filename_fig = paste("histograms", region, type, study_name, "uniformscalexy.pdf", sep=".")
    pdf (file = paste(output_figure_filepath, output_filename_fig)) 
    par(mfrow=c(6, 3))
    par(mar=c(4, 4, 1.2, 1.2))
    
    for (j in names_except_tot) {
      print(j)
      hist (dat.split[[j]]$value*quad, main = "", 
            xlab = paste(names(dat.split [j]), "(quads)"), ylab = "Frequency", ylim=c(0, y_max),  
            xlim=c(0, max_val_xaxis), breaks=c(c(0:40)*max_val/40), las = 0)
    }
    dev.off()
    
    output_filename_fig_tot = paste("histogram", region, type, study_name, "total.pdf", sep=".")
    pdf (file = paste(output_figure_filepath, output_filename_fig_tot)) 
    par(mfrow=c(6, 3))
    par(mar=c(4, 4, 1.2, 1.2))
    
    hist (dat.split[[total]]$value*quad, main = "", 
          xlab = paste(names(dat.split[total]), "(quads)"), ylab = "Frequency",
          xlim=c(0, max_val_xaxis), breaks=c(c(0:40)*(max(dat.split[[total]]$value)*quad)/40), las = 0) 
    dev.off()
    
  }
}

