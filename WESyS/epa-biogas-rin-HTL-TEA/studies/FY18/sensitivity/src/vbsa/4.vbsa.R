get.sensi.indices <- function(region, type, config_file, num_boot, energy_type, colScale) {
  # Source R script config file and define variables from file
  source(config_file)
  define.variables()
  
  # Set working directory 
  setwd (vbsa_working_directory)
  
  # Source functions
  library(gridExtra)
  library(boot)
  library(RColorBrewer)
  
  source ("vbsa.functions.R")
  source ("load.R")
  
  # Set parameters 
  study_name = paste("vbsa", type, region, vbsa_study_extension, sep=".")
  resultspath <- paste(root_data_path, "vbsa", region, type, vbsa_study_extension, "results", sep="/")
  figurepath <- paste(root_data_path, "vbsa", region, type, vbsa_study_extension, "figures", sep="/")
  dir.create(paste(root_data_path, "vbsa", sep="/"))
  dir.create(paste(root_data_path, "vbsa", region, sep="/"))
  dir.create(paste(root_data_path, "vbsa", region, type, sep="/"))
  dir.create(paste(root_data_path, "vbsa", region, type, vbsa_study_extension, sep="/"))
  dir.create(paste(resultspath))
  dir.create(paste(figurepath))
  vbsa_path = paste(root_design_path, vbsa_folder, sep="/")
  study_design_output_folder = paste(vbsa_path, study_name, sep="/")
  study_design_rda_filename = paste("sobol.design", region, type, study_name, "RDA", sep = ".")
  study_design_rda_filepath = paste(study_design_output_folder, study_design_rda_filename, sep = "/")
  
  # Display names energy type 
  energy_display_list <- list('Elec.total'='Total Energy Production from Elec', 
                             'CNG.total'='Total Energy Production from CNG', 
                             'PNG.total'='Total Energy Production from PNG', 
                             'CHP.total'='Total Energy Production from CHP', 
                             'HTL.total'='Total Energy Production from HTL',
                             'WWTP.total energy'='Total Energy Production POTW', 
                             'CAFO.total energy'='Total Energy Production CAFO', 
                             'LF.total energy'='Total Energy Production from LF',
                             'biogas.total'='Total Energy Production (all modules and types)')
  energy_type_display <- energy_display_list[energy_type]
  
  # Load VBSA study design 
  print("Loading study design")
  load(study_design_rda_filepath)
  
  # Load VBSA input data
  data_folder = paste(root_data_path, "vbsa", region, type, vbsa_study_extension, "vbsa_sets", sep="/")
  filename = "vbsa.input.RDA"
  load(paste(data_folder, filename, sep="/"))
  
  # Get the dataset name that corresponds to the output
  dataset <- data.list[grep(energy_type, data.list)]
  
  # Load the model results and set output to values 
  print("Loading results")
  print(dataset)
  load (dataset)
  output <- temp$value
  print("Data loaded")
  
  # Create histogram of output
  set <- unique(temp$factor)
  #filename = paste(set, energy_type, "histogram_1e-6.png", sep=".")
  #png (file = paste(figurepath, filename, sep="/"), width = 5, height = 8, units = 'in', res = 300)
  #hist(output/1e6)
  #dev.off()

  # Get study design settings
  print("Getting study design settings")
  #new.design <- dcast (vbsa.design, run ~ variable) 
  var.names <- unique(vbsa.design$variable) # don't include run number as variable - it's not included in the study design
  
  # Center output by subtracting the mean from output
  output.centered <- output - mean(output)
  
  # Get study parameters 
  k <- length(which(vbsa.design$run == 1)) #(as.numeric (length (unique (var.names)))) 
  #N <- as.numeric (max (vbsa.design$run)/(2*(k+1))) # this is the correct way to get N if the study has been designed to size of 2*N(k+1), which is how it should be designed to get second order effects
  
  # Create ANOVA model to verify results 
  print ("Creating ANOVA model")
  #vbsa.design <- vbsa.design[which(vbsa.design$variable == "Global Inputs.Unit Price Scenario Multiplier[PNG]" & vbsa.design$value < 3 | vbsa.design$variable != "Global Inputs.Unit Price Scenario Multiplier[PNG]")] # removes variable from 12jan CA sludge study
  #dcastdesign <- dcast(vbsa.design, run ~ variable)
  #designplusoutput <- cbind(dcastdesign[,-c(1)], output.centered)
  #lmmodel <- lm(output.centered ~ ., data=designplusoutput, na.action = "na.fail")
  #anova.model <- Anova (lmmodel, type = "II", p.adjust.methods = "bonferroni")
  #anova.df <- as.data.table (anova.model)
  #setnames (anova.df, c("SS", "df", "F", "P.value" ))
  #anova.df$factor <- row.names (anova.model)
  
  #total.ss <- sum (anova.df[1:k, 1]) + anova.df[k+1,1]
  #interaction.est <- anova.df[k+1,1] / total.ss #estimate the %var not explained by the dep var. since this is a deterministic model we can assume this is the remaining interactions
  #sig.factors <- subset (anova.df, P.value < 0.05)

  #lmsummary <- summary(lmmodel)
  #getcoeff <- lmsummary$coefficients[,"Pr(>|t|)"]
  #removeintercept <- getcoeff[which(getcoeff != 0)]
  #sigvariable <- removeintercept[which(removeintercept < 1e-3)]
  #sigvariable <- formatC(sigvariable, format = "e", digits = 2)
  #filename <- "sig_variable_lm.txt"
  #output_filepath = paste (figurepath, filename, sep="/")
  #write.table(sig.factors, output_filepath, sep="\t")
  
  
  # Split total output into A and B vectors (1xN) and C and D matrices (Nxk), see Saltelli 2008 ch. 4
  A.out <- output.centered[1:N] # (N x 1)
  B.out <- output.centered[(N+1):(N*2)] # (N x 1)
  
  C.out <- matrix(nrow=N, ncol=k)
  for(i in 1:k){
    C.out[,i] <- output.centered[((i+1)*N+1):((i+2)*N)]
  }
  
  D.out <- matrix(nrow=N, ncol=k)
  for(i in 1:k){
    D.out[,i] <- output.centered[((i+1+k)*N+1):((i+2+k)*N)]
  }
  
  ABCD <- cbind(A.out, B.out, C.out, D.out)
  
  # Calculate sens indicies
  print("Calculating sensitivity indicies")  
  sensitivity.results <- get.sensitivity (ABCD, boots = 5000, vars = var.names)
  
  sensitivity.results.2 <- get.second.order(ABCD, vars = var.names)
  
  # Save data 
  filename = paste(set, energy_type, 'sensitivity_results.RDA', sep=".")
  output_filepath = paste (figurepath, filename, sep="/")
  #save (sensitivity.results, sensitivity.results.2, file = output_filepath)

  # Organize First Order 
  df.1 <- subset (sensitivity.results, index == "S.i")
  low.quan.1 <- data.table (factor = var.names, lower = tapply (df.1$value, 
                                                              df.1$variable, quantile, probs = c(0.95), na.rm = TRUE))
  ns.1 <- subset (low.quan.1, lower > 0.1) #prior 0.1
  # if (nrow(ns.1) >= 5) {
  #   ns.1 <- ns.1[1:5, ]
  # }
  df.1 <- subset (df.1, df.1$variable %in% ns.1$factor)
  
  # Organize Total 
  
  df.2 <- subset (sensitivity.results, index == "S.t.i")
  low.quan.2 <- data.table (factor = var.names, lower = tapply (df.2$value, 
                                                                df.2$variable, quantile, probs = c(0.95), na.rm = TRUE))
  ns.2 <- subset (low.quan.2, lower > 0.1) #prior 0.1
  # if (nrow(ns.2) >= 5) {
  #   ns.2 <- ns.2[1:5, ]
  # }
  df.2 <- subset (df.2, df.2$variable %in% ns.2$factor)
  
  # Organize Second Order

  df.3 <- sensitivity.results.2

  df.3 <- subset (df.3, df.3$lower > 0.01)

  df.3 <- arrange (df.3, -df.3$est.value)
  #df.3 <- df.3[1:5,] #just for plotting purposes limit to 5 values
  df.3$comb <- paste (df.3$variable.i, df.3$variable.j, sep = " & ")

  results <- list("first_order" = df.1, "total_effects" = df.2)

  # variable_list <- unique(df.1$variable)
  # variable_list <- append(variable_list, unique(df.2$variable))
  # variable_list <- append(variable_list, unique(df.3$variable.i))
  # variable_list <- append(variable_list, unique(df.3$variable.j))
  # unique_variable <- as.data.frame(unique(variable_list))
  # unique_variable$variable_list <- as.factor(variable_list)

  # Plot First Order

  df <- df.1

  filename = paste(region, energy_type, "Si.png", sep=".")
  png (file = paste (figurepath, filename, sep = "/"), width = 10, height = 4, units = 'in', res = 300)# width = 3+(length(unique(df$variable))), height = 3, units = 'in', res = 300)

  gg <- ggplot (df, aes (x = df$variable, y = value, colour=df$variable)) +
    #theme (axis.text.x = element_text (angle = 75, hjust = 1)) +
    geom_boxplot(notch = TRUE, show.legend = TRUE) +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          legend.title=element_blank(),
          plot.margin=unit(c(0.5,10,0.5,0.5), "cm"),
          legend.margin=margin(c(0,0,0,0)),
          legend.position = c(1.4,0.5),
          panel.grid.major.x = element_blank()) +
    coord_cartesian(ylim=c(0,1), xlim=c(1,12)) +
    colScale +
  #  labs (title = paste(energy_type_display, "in", toupper(region), sep =' '), x = "Model Factor", y = expression ("S"["i"])) 
    labs (title = energy_type, x = "Model Factor", y = expression ("S"["i"])) 
  print(gg)
  dev.off()
  
  # Plot Total Effects

  df <- df.2

  filename = paste(region, energy_type, "Sti.png", sep=".")
  png (file = paste (figurepath, filename, sep = "/"), width = 10, height = 4, units = 'in', res = 300)#width = 3+(length(unique(df$variable))), height = 3, units = 'in', res = 300)

  gg <- ggplot (df, aes (x = df$variable, y = value, colour=df$variable)) +
    #theme (axis.text.x = element_text (angle = 75, hjust = 1)) +
    geom_boxplot(notch = TRUE, show.legend = TRUE) +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          legend.title=element_blank(),
          plot.margin=unit(c(0.5,10,0.5,0.5), "cm"),
          legend.margin=margin(c(0,0,0,0)),
          legend.position = c(1.4,0.5),
          panel.grid.major.x = element_blank()) +
    coord_cartesian(ylim=c(0,2), xlim=c(1,12)) +
    colScale +
    labs (title = energy_type, x = "Model Factor", y = expression ("St"["i"]))

  print(gg)
  dev.off()
  
  # Plot Second Order Effects 

  filename = paste(region, energy_type, "Sij.png", sep=".")
  png (file = paste (figurepath, filename, sep = "/"), width = 10, height = 4, units = 'in', res = 300)# width = 3+(length(unique(df$variable))), height = 3, units = 'in', res = 300)

  gg <- ggplot(df.3, aes(x = df.3$comb, colour = df.3$comb, ymin = df.3$lower,
                           lower = df.3$lower, middle = df.3$est.value,
                       upper = df.3$upper, ymax = df.3$upper)) +
    #theme (axis.text.x = element_text (angle = 75, hjust = 1, size = 8)) +
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          legend.title=element_blank(),
          plot.margin=unit(c(0.5,15,0.5,0.5), "cm"),
          legend.margin=margin(c(0,0,0,0)),
          legend.position = c(1.9,0.5),
          panel.grid.major.x = element_blank()) +
    coord_cartesian(ylim=c(0,1), xlim=c(1,12)) +
    labs (title = energy_type, x = "Model Factor", y = expression ("S"["ij"]))  +
    geom_boxplot(stat = "identity", show.legend = TRUE)
  print(gg)
  dev.off()
  
}

