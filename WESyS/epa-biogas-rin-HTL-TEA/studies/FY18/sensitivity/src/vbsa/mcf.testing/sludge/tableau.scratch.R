rm(list=ls())

#install.packages ("Rserve")
library (Rserve)
Rserve()

library (data.table)
library (dplyr)
library (kSamples)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/sludge/")
source ("get.ad.R")
load ("../foo.vbsa.design.RDA")
#load ("sampled.sorted.wwtp.total.RDA")

#out$index <- seq(from = 1, to = nrow(out), by = 1) #add sequence to allow ordered plotting
#write.csv (out, "tableau.test.rda")

