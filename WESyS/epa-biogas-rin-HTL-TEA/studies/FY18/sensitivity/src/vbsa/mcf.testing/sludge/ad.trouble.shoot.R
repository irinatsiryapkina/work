rm(list=ls())
R_LIBS= ("/home/R/library")

options (scipen = 999)
options (digits = 3)

library (data.table)
library (dplyr)
library (kSamples)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/sludge")

source ("../get.ad.R")

load ("study.design.RDA")
load ("wwtp.results.RDA")

setnames (vbsa.design, c("factor", "run_id", "value"))#desing and model results need to have the same names
#save (vbsa.design, file = "study.design.RDA")
temp <- out

max (temp$run_id)
max (vbsa.design$run)

#sample result for faster visulizatoins and testing

out <- dplyr::sample_frac(temp, 0.10, replace = FALSE)

out$value <- out$value/1000000

out <- out [,-c(3)]

setorder (out, value)

#plot (out$value)

max (out$value)

B <- subset (out, value > 550 & value < 600)

#setnames (out, c("run_id", "variable", "result"))

#setorder (out, "value")

#save (out, file = "sampled.sorted.wwtp.total.RDA")

#B <- dplyr::sample_frac(out, 0.10, replace = FALSE)

results <- get.ad (selection = B, design = vbsa.design, boots = 10, design.melted = TRUE)


