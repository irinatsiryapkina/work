#04052018
#MCF with AD k comparisons scratching
#data cave prototyping

rm(list=ls())
R_LIBS= ("/home/R/library")

library (data.table)
library (dplyr)
library (randtoolbox)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/")

#load functions
source ("../vbsa.functions.R")
#source ("../scratch/old.vs.new.R")

# generate data for 5 factors - this will be the basis of our model
#f4 is the dependant var. only f3 and f6 are influential, the rest are noise
foo <- data.table (f1 = runif(n = 1000, min = 1, max = 6000), f2 = rnorm (n = 1000, sd = 50, mean = 125), 
                   f3 = seq (from = 3001, to = 4000, by = 1) + rnorm (n = 1000, sd = 150, mean = 3500), 
                   y = seq (from = 0.001, to = 1, by = 0.001),
                   f4 = rpois (1000, 5), f5 = seq (from = 3001, to = 4000, by = 1) + rpois (1000, 10000))


foo.model <- lm (y ~ ., data = foo)

#now generate fast design for foo.model
study.vars <- read.csv ("foo.config.csv", header = TRUE, fileEncoding = "UTF-8-BOM")
study.min <- study.vars$min
study.max <- study.vars$max
var.names <- study.vars$factor

study.vars$delta <- study.vars$max - study.vars$min
vbsa.seed <- set.seed(12340)

# Set factors to study.vars 
factors <- study.vars
factors$set <- seq (from = 1, to = nrow(factors))
k <- nrow(study.vars)   # number of factors
N <- 500

qrs <- randtoolbox::sobol(N, dim = 2*k, seed = vbsa.seed)  

# Separate sequence into A and B matrices, each (N x factors)
A <- qrs[,1:k]
B <- qrs[,(k+1):(2*k)]

# Create C matrices
# For each factor, C = matrix B with column i taken from matrix A
C.runs <- matrix(nrow = N*k, ncol = k)

for(i in 1:k){
  print(i)
  C <- B
  C[,i] <- A[,i]
  C.runs[((i-1)*N+1):(i*N),] <- C
}

# Create D matrices
# For each factor, D = matrix A with column i taken from matrix B
D.runs <- matrix(nrow = N*k, ncol = k)

for(i in 1:k){
  print(i)
  D <- A
  D[,i] <- B[,i]
  D.runs[((i-1)*N+1):(i*N),] <- D
}

# Combine matrices
runs <- rbind(A, B, C.runs, D.runs) 

# Transform data; each column represents a unique Variable + Subscript 1 + Subscript 2 + Index
#combination.  Rows represent the individual runs.
a <- t(factors$set)
b <- 1 : dim(runs)[2]
z <- matrix(a, nrow = length(b), ncol = length(a), byrow = TRUE)
zz <- apply(b == z, c(1,2), function(x) {if (x) 1 else 0})
w <- runs %*% zz

# Take result and put into model format
new.design <- w * matrix(factors$delta, nrow = dim(runs)[1], ncol = length(a), 
                         byrow = TRUE) + matrix(factors$min, nrow = dim(runs)[1], 
                                                ncol = length(a), byrow = TRUE)

colnames (new.design) <- study.vars$factor

vbsa.design <- as.data.table (new.design)

vbsa.design$run_id <- seq (from = 1, to = nrow (vbsa.design), by =1)

save (vbsa.design, file = "foo.vbsa.design.RDA")

#run study design through model and collect the results
foo.sobol.output <- predict.lm (foo.model, vbsa.design, interval = "prediction", type = "response")
foo.sobol.output <- as.numeric (foo.sobol.output[,"fit"])
save (foo.sobol.output, file = "foo.out.RDA")
plot (foo.sobol.output)

