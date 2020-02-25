#D. Inman
#1.17.2018
#big memory scratching
rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/scratch/")

library (bigmemory)
library (biganalytics)
library (parallel)
#library (dplyr)
#library (data.table)
library (boot)

#the standard "big.matrix" just points to the matrix in C++ and avoids pitfalls of a regular matrix
#the size of a big.matrix is limited by available RAM
#gc (reset = TRUE)

foo <- big.matrix (nrow = 1000000, ncol = 500) 

for (i in 1:ncol (foo)){
  foo [,i] <- runif (nrow (foo), min = 0, max = 1000)
}

object.size (foo) #checking the size of the matrix held in memory

gc () #garbage collection to see mem allocated to an operation

#now test with parallel
no.cores <- detectCores () 

cl <- makeCluster (no.cores, type = "SOCK") #use type = FORK on non-Win environ

Rprof ("example.1.out", memory.profiling = TRUE)
test.1 <- parRapply (cl, foo, sample, size = 1000, replace = TRUE) #parCapply = columnwise, parRapply = rowwise
Rprof (NULL)
summaryRprof("example.1.out")

Rprof ("example.2.out", memory.profiling = TRUE)
test.2 <- apply (foo, 1, sample, size = 1000, replace = TRUE)
Rprof (NULL)
summaryRprof("example.2.out")



foo.2 <- matrix (nrow = 1000000, ncol = 500) 

for (i in 1:ncol (foo.2)){
  foo.2 [,i] <- runif (nrow (foo.2), min = 0, max = 1000)
}

Rprof ("example.3.out",  memory.profiling = TRUE)
test.3 <- apply (foo.2, 1, sample, size = 1000, replace = TRUE)
Rprof (NULL)
summaryRprof("example.3.out")


