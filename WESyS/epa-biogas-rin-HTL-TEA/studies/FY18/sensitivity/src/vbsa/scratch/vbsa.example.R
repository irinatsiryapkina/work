#testing new sensi functions and bootstrapping
#using bsm study 1006 as an example
rm(list=ls())

library (dplyr)
library (data.table)
library (boot)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/")
source ("get.sensitivity.R")
options(scipen=999)
# Load data and set following parameters

load ("scratch/foo.design.RDA") #design
#load the model output data
load ("scratch/foo.output.RDA")#model input for study 
output <- chc.prod.2045$total

# Get Study Design Settings
new.design <- dcast (foo.design, run ~ variable + sub1 + sub2)
var.names <- c(colnames (new.design))
k <- as.numeric (length (unique (var.names)))
N <- as.numeric (max (foo.design$run)/(2*k))

#center output by subtracting the mean from output
output.centered <- output - mean(output)

#split total output into A and B vectors (1xN) and C and D matrices (Nxk), see Saltelli 2008 ch. 4
A.out <- output.centered[1:N] # (N x 1)
B.out <- output.centered[(N+1):(N*2)] # (N x 1)

C.out <- matrix(nrow=N, ncol=k)
for(i in 1:k){
  C.out[,i] <- output.centered[((i+1)*N+1):((i+2)*N)]
}

D.out <- matrix(nrow=N, ncol=k)
for(i in 1:k){
  D.out[,i] <- output.centered[((i+1+k)*N+1):((i+2+k)*N)]
}

ABCD <- cbind(A.out, B.out, C.out, D.out)

#calculate sens indicies

sensitivity.results <- get.sensitivity (ABCD, k, 5000, var.names)


