rm(list=ls())
R_LIBS= ("/home/R/library")

library (data.table)
library (dplyr)
library (kSamples)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/")

source ("get.ad.R")

load ("foo.vbsa.design.RDA")
load ("selection.RDA")

results <- get.ad (selection = B, design = vbsa.design, boots = 5)
