#D.Inman
#Nov 14 2018
#CART analysis of Q1 HTL study

rm (list = ls()) 

library (data.table)
library (dplyr)
library (bit64)
#library (rpart)
#library (rpart.utils)
setwd ("~/GitHub/epa-biogas-rin/studies/FY19/Q1/src/")
# output_directory <- "~/GitHub/epa-biogas-rin/studies/FY19/Q1/results"
# #source ("do.cart.R")
# 
# #input data from the VBSA study design and results
# #vbsa study design
# wesys_study_root_dir <- "~/Box Sync/WESyS_Project/Study_Designs/FY19/vbsa_design/vbsa.all.joined.q1_12factors_31oct"
# load (paste(wesys_study_root_dir, "sobol.design.joined.all.vbsa.all.joined.q1_12factors_31oct.RDA", sep="/"))
# setorder (vbsa.design, run, variable)
# inputs <- dcast (vbsa.design, run ~ variable)

#wesys vbsa outputs
# wesys_results_root_dir <- "~/Box Sync/WESyS_Project/data_wte/vbsa/joined/all/q1_12factors_31oct/wesys_results"
# load (paste(wesys_results_root_dir, "vbsa.joined.all.q1_12factors_31oct.wesys.results.timeseries.RDA", sep="/"))

out.data <- data.table::fread ("../data/wesys_out_2040.csv")#faster load for large files ~ RAM
out.data <- data.table (run = out.data$run_id, factor = out.data$factor, value = out.data$value)
save (out.data, file = "../data/wesys.2040.RDA")
out <- out.data

#select only HTL outputs
output.factors <- as.data.table (unique (out$factor))
htl.factors <- output.factors [output.factors$V1 %like% "pro", ] #dplyr wrapper for grep
htl.factors <- htl.factors [htl.factors$V1 %like% "HTL", ]
total.factors <- htl.factors [htl.factors$V1 %like% "total energy", ]
totalandhtl <- unique(rbind(htl.factors, total.factors))
htl.out <- subset (out, out$factor %in% htl.factors$V1)
#total.out <- subset(out, out$factor %in% total.factors$V1)
#order by run number
setorder (htl.out, run)
save (htl.out, file = "wesys.htl.2040.RDA") 

# #split into a list of data tables in wide format for input to cart
# htl.out.ls <- split (htl.out, by = "factor")
# htl.out.ls <- lapply (htl.out.ls, function (x) dcast (x, run ~ factor))
# htl.out.ls <- lapply (htl.out.ls, function (x) setnames (x, c("run", "value")))
# study.data.ls <- lapply (htl.out.ls, function (x) as.data.table (cbind (inputs, x$value)))
# 
# htl.summary <- lapply (htl.out.ls, function (x) summary (x$value))