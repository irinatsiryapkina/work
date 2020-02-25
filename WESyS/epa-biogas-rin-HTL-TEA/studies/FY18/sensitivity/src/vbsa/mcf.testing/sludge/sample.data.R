rm(list=ls())
R_LIBS= ("/home/R/library")

library (data.table)
library (dplyr)
library (kSamples)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/sludge")

source ("get.ad.R")

load ("study.design.RDA")
load ("wwtp.results.RDA")

setnames (vbsa.design, c("factor", "run_id", "value"))#desing and model results need to have the same names
save (vbsa.design, file = "study.design.RDA")

max (wwtp.results$run_id)
max (vbsa.design$run)

# get total only
wwtp.results.tot <- wwtp.results[which(wwtp.results$factor == "wwtp.total")]

#sample result for faster visulizatoins and testing

out <- dplyr::sample_frac(wwtp.results.tot, 0.10, replace = FALSE)

out <- subset(out, select = c(run_id, factor, value))
 
setnames (out, c("run_id", "factor", "result"))

setorder (out, "result")

save (out, file = "sampled.sorted.wwtp.total.RDA")

plot (out$result)
#just a test

#B <- dplyr::sample_frac(out, 0.10, replace = FALSE)

B <- subset (out, result > 8500000)

results <- get.ad (selection = B, design = vbsa.design, boots = 5, design.melted = TRUE)

str(B)
str(vbsa.design)
