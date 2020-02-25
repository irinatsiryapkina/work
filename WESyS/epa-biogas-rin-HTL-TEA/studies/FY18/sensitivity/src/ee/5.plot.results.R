#D. Inman
#12.02.2017
#EE analysis

rm(list=ls())
R_LIBS= (r_library_path)
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)

# Set parameters
setwd (ee_working_directory)
wesys_results_folder = paste(root_data_path, study_name, wesys_results_folder, sep="/")

# Load libraries 
library (dplyr)
library (data.table)
library (ggplot2)
library(gridExtra)
library(Hmisc)


for (region in region_list){ 
  for (type in type_list){
    print(region)
    print(type)
    
    results_rda_filename = paste("ee", region, "wesys", "results", "RDA", sep=".")
    results_rda_filepath = paste(wesys_results_folder, ee_study_name, results_rda_filename, sep="/") 

    fig_subfolder = paste(region, type, sep=".")
    figname = paste(region, type, "results.pdf", sep=".")
    figure_filepath = paste(figures_folder, fig_subfolder, figname, sep="/")
    
    region_name = paste(region, " ")
    
    load (results_rda_filepath)
    
    setorder (out, run_id, time)
    
    out2 <- out
    results <- out2[which(out2$run_id %in% sample(out2$run_id, 1000))] 
    
    if (type == "sludge") {
      results <- results [grep ("WWTP", results$factor), ] #grabbing the WWTP runs
      max_val <- 0.08 #round(max(slg2$quad)*1.1,2)
      ncol <- 4
      nrow <- 3 
      width <- 11/3*4
      height <- 8.5
    }
    
    if (type == "biogas") { 
      results <- results [!grep ("HTL", results$factor), ] #remove HTL - for biogas only 
      max_val <- 1.1 #round(max(slg2$quad)*1.1,2)
      ncol <- 3
      nrow <- 3 
      width <- 11
      height <- 8.5
    }
    
    results <- results [grep ("tot", results$factor), ] #grabbing the total energy runs
    results <- results [!grep ("BC", results$factor), ] #remove BC - no production
    results <- results [!grep ("CF", results$factor), ] #remove CF - no production
    results <- results [!grep ("FT", results$factor), ] #remove CF - no production
    results <- results [!grep ("NoWTE", results$factor), ] #remove No WTE - no production
    
    #output energy units are in GJ 
    #convert to Quads - 1 GJ = 9.47086 E-10 quads
    quad <- 9.47086 * 10^-10 #conversion factor
    results$quad <- results$value * quad
    #slg2 <- slg 
    

    single_result <- results[which(results$run_id %in% list(results$run_id[1]))]
    factor_list <- unique(single_result$factor)
    ggvect <- vector("list", length(factor_list))
    i <- 1 
    
    for (factor_name in factor_list){
      print(factor_name)
      #plot sludge.elec
      df <- subset (results, factor == factor_name)
      
      gg <- ggplot (data = df, aes (x = time, y = quad, group = interaction (run_id, factor), 
                                    color = factor)) + 
        #scale_color_brewer(palette = "Set1") +
        
        geom_line (color = "black") + 
        
        ylim (0, max_val) +
        
        labs(title = paste(toupper(region), capitalize(type), factor_name, sep = " "), 
             x = "Simulation Year", 
             y = "Energy Production (quads)")
      
      ggvect[[i]] <- gg

      #dev.off ()
      i <- i + 1 
    }
    
    ggsave (figure_filepath, arrangeGrob(grobs=ggvect, ncol=ncol, nrow=nrow), device = "pdf",
            width = width, height = height)
  
    #dev.off ()
  }
}



