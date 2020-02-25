#D. Inman
#11.21.2017
#EE analysis

rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)

# Set parameters 
#setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")
setwd ("~/ws/src/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")
study_design_folder = "~/Box Sync/WESyS_Project/Study_Designs/FY18/sa_design"
study_name = "test_rotus_25traj_2jan2017"
rda_results_folder = paste("~/data_wte", study_name, "wesys_results", sep="/")
local_rda_folder = paste("~/data_wte", study_name, "ee_results", sep="/")
figures_filepath = paste("~/data_wte", study_name, "figures", sep="/")
dir.create(paste("~/data_wte", study_name, sep="/"))
dir.create (local_rda_folder)
dir.create(figures_filepath)
design_filepath = "designs"

type_list = list("sludge", "biogas")
region_list = list("rotus")#("ca", "rotus")
r <- 25
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

infl.factors <- function (data, q1 = NULL)  {
  if (is.null (q1))
  {
    df <- subset (data, mu.star > quantile (data$mu.star, 0.9) &
                    sigma > quantile (data$sigma, 0.9) | sigma >
                    quantile (data$sigma, 0.9) | mu.star >
                    quantile(data$mu.star, 0.9))
    return (df)
  }
  df <- subset (data, mu.star > quantile (data$mu.star, q1) &
                  sigma > quantile (data$sigma, q1) | sigma >
                  quantile (data$sigma, q1) | mu.star >
                  quantile(data$mu.star, q1))
  return (df)
}

source ("sens.functions.R")

for (region in region_list){ 
  print(region)
  
  # Generate EE design config name 
  ee_design_config_filename = paste(region, "ee", study_name, "csv", sep=".")
  ee_design_config_filepath = paste(design_filepath, ee_design_config_filename, sep="/")
  
  # Load study config file
  vars <- read.csv(ee_design_config_filepath)
  #vars <- vars[,1:5]
  
  # Load Morris Model Design Generated
  sa_filename = paste("sa.design", region, study_name, "RDA", sep=".")
  sa_design_filepath = paste(study_design_folder, study_name, sa_filename, sep="/")
  load(sa_design_filepath)
  
  N <- nrow (vars)
  
  # Load the Output from the Model Run
  results_rda_filename = paste("ee", region, study_name, "wesys.results.RDA", sep=".")
  results_rda_filepath = paste(rda_results_folder, results_rda_filename, sep="/")
  load (results_rda_filepath)
  
  out <- setorder (out, factor) #arrange by factor
  out <- subset (out, time == 2040) #just selct 2040 for analysis
  out <- out [, ("time"):=NULL] #drop the time column now that only 2040 has been selected
  
  # Loop through types of feedstock (e.g., sludge, biogas)
  for (type in type_list){ 
    print(type)

    output_type_filename = paste("ee.results", region, type, study_name, "RDA", sep=".")
    output_type_filepath = paste(local_rda_folder, output_type_filename, sep="/")
  
    output_sig_type_filename = paste("sig.ee.results", region, type, study_name, "RDA", sep=".")
    output_sig_type_filepath = paste(local_rda_folder, output_sig_type_filename, sep="/")
    
    if (type == "sludge"){
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
      
      if (region == "ca"){
        max_val_xaxis = 1e-2
        max_val = max_val_xaxis
      }
      
      if (region == "rotus"){
        max_val_xaxis = 0.045#0.39#0.17
        max_val = max_val_xaxis
      }
      y_max = 6e5#8e5
    }
   
    if (type == "biogas"){
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
      
      if (region == "ca"){
        max_val_xaxis = 1.2e-1
      }
      
      if (region == "rotus"){
        max_val_xaxis = 0.4
      }
      
      y_max = 9e5#8e5
    }
    
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
    
    if (type == "sludge"){
      typetot = "WWTP"
    }
    if (type == "biogas"){
      typetot = type 
    }
    
    total <- paste(typetot, "total", sep=".")
    ee.results.total <- ee.results[[total]]
    
    sig.factors <- infl.factors(ee.results.total, q1=0.95)
    
    table_name_list <- list("sig.fac", "ee.results.total")
    table_list <- list(sig.factors, ee.results.total)
    
    k <- 1 
    for (table in table_list){
      output_filename_fig = paste("mustar_sigma", table_name_list[[k]], region, type, "pdf", sep=".")
      pdf(file = paste(figures_filepath, output_filename_fig, sep="/"))
      plot(table$mu.star, table$sigma)
      short.names <- abbreviate(table$set, minlength = 12)
      text(table$mu.star, table$sigma, short.names, adj = c(1.5,0.5))
      dev.off()
      k <- k + 1 
    }
    
    #sig.factors <- lapply (ee.results, function (x) subset (x, std.errors < 2))
    save (sig.factors, file = output_sig_type_filepath)
    
    #plot histograms of each output
    names_plots <- names(dat.split)
    
    name_tot <- c(total)
    names_except_tot <- names_plots[which(!names_plots%in%name_tot)]

    output_filename_fig = paste("histograms", region, type, study_name, "uniformxcale.pdf", sep=".")
    pdf (file = paste(figures_filepath, output_filename_fig, sep="/")) 
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
    
    # Other plotting options - currently unused 
    
    #output_filename_fig = paste("histograms", region, type, study_name, "raw.pdf", sep=".")
    #pdf (file = paste(figures_filepath, output_filename_fig, sep="/")) 
    #par(mfrow=c(6, 3))
    #par(mar=c(4, 4, 1.2, 1.2))
    
    #for (j in names_except_tot) {
    #  print(j)
    #  hist (dat.split[[j]]$value*quad, main = "", 
    #        xlab = paste(names(dat.split [j]), "(quads)"), ylab = "Frequency", las = 0)  
    #}
    #dev.off()
    
    #output_filename_fig = paste("histograms", region, type, study_name, "uniformscalexy.pdf", sep=".")
    #pdf (file = paste(figures_filepath, output_filename_fig, sep="/")) 
    #par(mfrow=c(6, 3))
    #par(mar=c(4, 4, 1.2, 1.2))
    
    #for (j in names_except_tot) {
    #  print(j)
    #  hist (dat.split[[j]]$value*quad, main = "", 
    #        xlab = paste(names(dat.split [j]), "(quads)"), ylab = "Frequency", ylim=c(0, y_max),  
    #        xlim=c(0, max_val_xaxis), breaks=c(c(0:40)*max_val/40), las = 0)
    #}
    #dev.off()
    
    output_filename_fig = paste("histogram", region, type, study_name, "total.pdf", sep=".")
    pdf (file = paste(figures_filepath, output_filename_fig, sep="/")) 
    par(mfrow=c(6, 3))
    par(mar=c(4, 4, 1.2, 1.2))
    
    hist (dat.split[[total]]$value*quad, main = "", 
          xlab = paste(names(dat.split[total]), "(quads)"), ylab = "Frequency",
          #xlim=c(0, max_val_xaxis), 
          breaks=c(c(0:40)*(max(dat.split[[total]]$value)*quad)/40), las = 0) 
    dev.off()
    
  }
}

