#testing new sensi functions and bootstrapping
#using bsm study 1006 as an example
rm(list=ls())

library (dplyr)
library (data.table)
library (boot)
library (ggplot2)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/")
source ("vbsa.functions.R")
options(scipen=999)
# Load data and set following parameters

load ("scratch/foo.design.RDA") #design
#load the model output data
load ("scratch/foo.output.RDA")#model input for study 
output <- chc.prod.2045$total

# Get Study Design Settings
new.design <- dcast (foo.design, run ~ variable + sub1 + sub2)
#var.names <- c(colnames (new.design [, -c(1)]))
#k <- as.numeric (length (unique (var.names)))
#N <- as.numeric (max (foo.design$run)/(2*k))

#center output by subtracting the mean from output
output.centered <- output - mean(output)

#first run a linear model on the data
#join the data
foo.data <- cbind (output.centered, new.design [, -c("run")])

#install.packages ("car") #regression tools
#install.packages ("MuMIn")

library ("car")
#library ("MuMIn")

#just a test
lm.model <- lm (output.centered ~ ., data = foo.data, na.action = "na.fail")
anova.model <- Anova (lm.model, type = "II", p.adjust.methods = "bonferroni")
anova.df <- as.data.table (anova.model)
setnames (anova.df, c("SS","df", "F", "P.value" ))
anova.df$factor <- row.names (anova.model)

total.ss <- sum (anova.df[1:105, 1]) + anova.df[106,1]

interaction.est <- anova.df[106,1]/total.ss #estimate the %var not explained by the dep var. since this is a deterministic model we can assume this is the remaining interactions

sig.factors <- subset (anova.df, P.value < 0.05)

