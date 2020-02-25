#D.Inman
#Nov 14 2018
#CART analysis of Q1 HTL study

rm (list = ls()) 

library (data.table)
library (dplyr)
library (rpart)
library (rpart.utils)
setwd ("~/GitHub/epa-biogas-rin/studies/FY19/Q1/src/")
output_directory <- "~/GitHub/epa-biogas-rin/studies/FY19/Q1/results"
source ("do.cart.R")

#input data from the VBSA study design and results
#vbsa study design
wesys_study_root_dir <- "~/Box Sync/WESyS_Project/Study_Designs/FY19/vbsa_design/vbsa.all.joined.q1_12factors_31oct"
load (paste(wesys_study_root_dir, "sobol.design.joined.all.vbsa.all.joined.q1_12factors_31oct.RDA", sep="/"))
setorder (vbsa.design, run, variable)
inputs <- dcast (vbsa.design, run ~ variable)

#wesys vbsa outputs
wesys_results_root_dir <- "~/Box Sync/WESyS_Project/data_wte/vbsa/joined/all/q1_12factors_31oct/wesys_results"
output_data <- data.table::fread (paste(wesys_results_root_dir, "vbsa.joined.all.q1_12factors_31oct.wesys.results.timeseries.csv", sep="/"))

#load ("../data/wesys.htl.2040.RDA")
#setnames (htl.out, c("run_id", "factor", "value"))

#select only HTL outputs
output.factors <- as.data.table (unique (output_data$factor))
prod.factors <- output.factors [output.factors$V1 %like% "pro", ] #dplr wrapper for grep
htl.factors <- prod.factors [prod.factors$V1 %like% "HTL", ]
total.factors <- prod.factors [prod.factors$V1 %like% "total energy", ]
other_factors <- output.factors[1159:1160]
totalandhtl <- unique(rbind(htl.factors, total.factors, other_factors))

#newfactors <- totalandhtl %>% filter(!grepl(".*Run 1.*", V1))
htl.out <- subset (output_data, output_data$factor %in% totalandhtl$V1)
#total.out <- subset(out, out$factor %in% total.factors$V1)
#order by run number

#setorder (htl.out, run_id)

#split into a list of data tables in wide format for input to cart
htl.out.ls <- split (htl.out, by = "factor")
htl.out.ls <- lapply (htl.out.ls, function (x) dcast (x, run_id ~ factor))
htl.out.ls <- lapply (htl.out.ls, function (x) setnames (x, c("run", "value")))
study.data.ls <- lapply (htl.out.ls, function (x) as.data.table (cbind (inputs, x$value)))

htl.summary <- lapply (htl.out.ls, function (x) summary (x$value))
#write.csv (unlist (htl.summary), file = paste(output_directory, "htl.prod.summary.csv", sep="/"))

#center and scale data mean = 0, var = 1, run_id is dropped here
#data.ls <- lapply (study.data.ls, function (x) as.data.table (scale (x [,2:14])))
#str (data.ls[[3]])

#use function and lapply here
#fit a regression tree to HTL production using ANOVA. control is set to 0.001
cart.ls <- lapply (study.data.ls, do.cart)
cart.ls <- cart.ls [lapply(cart.ls, function(x) length (grep ("failed", x,value = FALSE))) == 0]#remove all list elements that rpart failed

#plot as png
plot.regtree <- function (fit, title) {
  png(paste (output_directory, "/", title, ".png", sep = ""), width = 1200, height = 800)
  data <- fit$title
  tab_results <- data$frame
  subrules <- rpart.subrules.table(data)
  colnames(subrules)[colnames(subrules)=="Variable"] <- "var"
  output <- merge(x = tab_results, y = subrules, by="var", all.x = TRUE)
  
  write.csv(output, file = paste(output_directory, "/", title, ".csv", sep=''))
  
  post(fit, file = "", title = title, bp = 18)
  dev.off()
}

#plot.regtree(cart.ls[[3]], names (cart.ls[3]))
tryCatch (
  {
    for (i in 1:length (cart.ls))
      {

      title <- names(cart.ls[i])
      fit <- cart.ls[[i]]
      #png(paste (output_directory, "/", title, ".png", sep = ""), width = 1200, height = 800)
      data <- fit
      tab_results <- data$frame
      subrules <- rpart.subrules.table(data)
      colnames(subrules)[colnames(subrules)=="Variable"] <- "var"
      output <- merge(x = tab_results, y = subrules, by="var", all.x = TRUE)
      output_split <- output %>% separate(var, c("Module factor", "Factor"), sep="[.]")
      output_split$title <- title
      output_split <- output_split %>% separate(title, c("module_variable", "variable"), sep="[.]")
      output_split <- output_split %>% separate(variable, c("variable", "type"), sep="\\[")
      output_split <- output_split %>% separate(module_variable, c("Region", "Energy Type"), sep=" ")
      output_split <- output_split %>% separate(type, c("type", "bracket"), sep="\\]")
      
      
      if (i == 1) {
        output_all <- output_split[0, ]
      }
      
      output_all <- rbind(output_all, output_split)
      write.csv(output, file = paste(output_directory, "/", title, ".csv", sep=''))
      
      post(fit, file = "", title = title, bp = 18)
      dev.off()
      capture.output (cart.ls[[i]], file = paste(output_directory, names(cart.ls[i]), ".txt", sep=""))
    }
  },
    error = function (e) {
    png ("error.png")
  })
dev.off()
write.csv(output_all, file = paste(output_directory, "/", "all_outputs_cart_ca_rotus_tot", ".csv", sep=''))


