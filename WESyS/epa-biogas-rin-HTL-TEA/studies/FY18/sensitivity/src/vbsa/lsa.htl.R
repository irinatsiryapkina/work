#D.Inman
#5/7/2018
#local sensitivity analysis of high and low HTL runs from WESyS

rm(list=ls())
R_LIBS= ("/home/R/library")

library (data.table)
library (dplyr)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/")

#load HTL results
load ("~/Box Sync/WESyS_Project/data_wte/vbsa/ca/sludge/fixedfactornew/vbsa_sets/WWTP.HTL tot.RDA")
out <- temp
setorder (out, value)
out$index <- seq (from = 1, to = length (out$value))
plot (out$index, out$value)

high.htl <- subset (out, value > 400000)

max (out$value)

tail (high.htl)

#load VBSA study design
load("~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design/vbsa.sludge.ca.fixedfactornew/sobol.design.ca.sludge.vbsa.sludge.ca.fixedfactornew.RDA")

high.design <- subset (vbsa.design, vbsa.design$run %in% high.htl$run_id)

length (unique (high.design$run))

high.design.wide <- dcast (high.design, run ~ variable)


write.csv (high.design.wide, file = "high.htl.runs.csv")

#looking at design settings vs htl production

correlation.results <- cor (temp$value, dcast (vbsa.design, run ~ variable))

#design.sub <- subset (vbsa.design, vbsa.design$variable == "Global Inputs.per tonne tipping fee")

design.sub <- subset (vbsa.design, vbsa.design$variable == "WWTP.Reqd Rate of Return as Pct")

setorder (design.sub, run)
setorder (temp, run_id)           

set.1 <- data.table (run = temp$run_id, htl = temp$value, ror = design.sub$value)

plot (set.1$ror, set.1$htl)





     