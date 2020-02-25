#D. Inman
#12.02.2017
#EE analysis

rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")

# Load libraries 
library (dplyr)
library (data.table)


load ("results/ee.ca.sludge.2040.RDA")

df <- as.data.table (ee.results)
df <- subset (ee.results, std.errors < 1)
df <- setorder (df, -mu.star)


df <- df[-grep ("LF", df$factor),]

sig.factors <- df[-grep ("CAFO", df$factor),]

save (sig.factors,file = "for.vbsa/vbsa.ca.sludge.config.RDA" )

write.csv (sig.factors[,2:5], file = "for.vbsa/vbsa.ca.sludge.config.csv") 

###biogas

load ("results/ee.ca.biogas.2040.RDA")

df <- as.data.table (ee.results)
df <- subset (ee.results, std.errors < .5)
df <- setorder (df, -mu.star)


df <- df[-grep ("LF", df$factor),]

sig.factors <- df[-grep ("CAFO", df$factor),]

save (sig.factors,file = "for.vbsa/vbsa.ca.biogas.config.RDA" )

write.csv (sig.factors[,2:5], file = "for.vbsa/vbsa.ca.biogas.config.csv") 
 