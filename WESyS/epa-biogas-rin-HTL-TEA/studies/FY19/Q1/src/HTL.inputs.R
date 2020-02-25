#D.Inman
#Nov 14 2018

rm (list = ls()) 

library (data.table)
library (dplyr)

setwd ("~/GitHub/epa-biogas-rin/studies/FY19/Q1/src/")

#load all 2040 results
load ("../data/wesys.2040.RDA") 

#subset to get the total energy production for 2040
output.factors <- as.data.table (unique (out.data$factor))
temp <- output.factors [output.factors$V1 %like% "Global Outputs.total energy prod", ] #dplr wrapper for grep
total.energy <- subset (out.data, out.data$factor %in% temp)
setorder (total.energy, run)
rm(out.data, temp, output.factors)

#load only HTL results
load ("../data/wesys.htl.2040.RDA") 
total.htl <- subset (htl.out, factor == "Global Outputs.global total energy prod by config[HTL]")

#join total and total htl
data <- data.table (run = total.htl$run, total.energy = total.energy$value, htl.total = total.htl$value,
                    htl.pct = total.htl$value/total.energy$value)

rm (htl.out, total.energy, total.htl)

htl.set <- subset (data, htl.pct > 0.02 | htl.pct == 0.02)

#load study settings
load ("../data/sobol.design.joined.all.vbsa.all.joined.q1_12factors_31oct.RDA")

#select runs that have htl production > 2% of the ma

htl.settings <- subset (vbsa.design, vbsa.design$run %in% htl.set$run)

htl.temp <- dcast (htl.settings, run ~ variable)

htl.settings <- print (summary (htl.temp))

write.table (htl.settings, "../results/htl.input.summary.txt")

#boxplot (htl.temp[, -c(1)])

all.temp <- dcast (vbsa.design, run ~ variable)

all.settings <- print (summary (all.temp))

write.table (all.settings, "../results/all.input.summary.txt")

