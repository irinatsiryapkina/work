rm(list=ls())
R_LIBS= ("/home/R/library")

options(scipen=999)
options (digits = 3)

library (data.table)
library (dplyr)
library (kSamples)
library (ggplot2)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/sludge/")

#load the anderson-darling functions
source ("get.ad.R")

#load the study design
load ("study.design.RDA")

#load the study results
load ("sampled.sorted.wwtp.total.RDA") #these data are sorted by produciton level "result"

out$index <- seq(from = 1, to = nrow(out), by = 1) #add sequence to allow ordered plotting

out$result <- out$result/1000000

setorder (out, result)

ggplot(out, aes(index, result)) + geom_point(color = "light blue")

B <- subset (out, result > 5.5 & result < 6)

test <- cbind (sig.results$factor, B.summary$factor, B.bar.summary$factor)
