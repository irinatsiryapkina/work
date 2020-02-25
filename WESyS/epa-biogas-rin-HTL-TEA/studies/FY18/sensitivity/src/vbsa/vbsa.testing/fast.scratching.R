##FAST example
#fake data, fake model
#D.Inman 03282018

rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off

library (data.table)
library (dplyr)
library (fast)
library (randtoolbox)
library(sensitivity)
library (boot)
library (ggplot2)

# Set parameters
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/vbsa.testing/")

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
summary (foo.model)
plot (foo)

#now generate fast design for foo.model
study.vars <- read.csv ("foo.config.csv", header = TRUE, fileEncoding = "UTF-8-BOM")

study.min <- study.vars$min
study.max <- study.vars$max
var.names <- study.vars$factor
fast.design <- fast_parameters (study.min, study.max, names = paste (var.names))

#put the fast design into a stella input format
temp <- as.data.table (fast.design)
temp$run_id <- as.factor (seq (from = 1, to = nrow(fast.design), by = 1))
fast.design.tidy <- melt (temp)
save (fast.design.tidy, file = "fast.design.in.model.format.RDA")
rm (temp, fast.design.tidy)


#run the model with the fast design as input
foo.output <- predict.lm (foo.model, fast.design, interval = "prediction", type = "response")
foo.output <- as.numeric (foo.output [,1])
plot(foo.output)

#perform FAST and plot results
#FAST calc the first-order sensitivity index
#sum FAST results, if sum is < 1, then the model is additive. 1 - sum(FAST)
#gives an indication of the interaction effects
foo.sensitivity <- sensitivity (x = foo.output, numberf = 5, make.plot = TRUE)

#capture the sens indicies
foo.fast <- sensitivity

#Now perform VBSA using Saltelli and Sobol approaches
#now generate an sobol qrs study for foo.model
study.vars$delta <- study.vars$max - study.vars$min
vbsa.seed <- set.seed(12340)

# Set factors to study.vars 
factors <- study.vars
factors$set <- seq (from = 1, to = nrow(factors))
k <- nrow(study.vars)   # number of factors
N <- 5000

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

#save (vbsa.design, file = "foo.vbsa.design.RDA")

#run study design through model and collect the results

foo.sobol.output <- predict.lm (foo.model, vbsa.design, interval = "prediction", type = "response")
foo.sobol.output <- as.numeric (foo.sobol.output [,1])
plot (foo.sobol.output)

#center output by subtracting the mean from output
output.centered <- foo.sobol.output - mean(foo.sobol.output)

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

var.names <- as.character (study.vars$factor)

vbsa.results <- get.sensitivity (ABCD, boots = 10000, vars = var.names)


####Plot Results #####
#First Order
df.1 <- subset (vbsa.results, index == "S.i")

low.quan <- data.table (factor = var.names, lower = tapply (df.1$value, 
                                                            df.1$variable, quantile, probs = c(0.01), na.rm = TRUE))

ns <- subset (low.quan, lower > 0)

df.1 <- subset (df.1, df.1$variable %in% ns$factor)

rm (low.quan, ns)

#filename = paste( set, "Si.png", sep=".")
#png (file = paste (figurepath, filename, sep = "/"))

df <- df.1

gg <- ggplot (df, aes (x = df$variable, y = value, colour = df$variable)) +
  geom_boxplot(notch = TRUE, show.legend = FALSE) + 
  labs (title = "First Order Index", x = "Model Factor", y = expression ("S"["i"]))

gg

#Total Effects

df.2 <- subset (vbsa.results, index == "S.t.i")

low.quan <- data.table (factor = var.names, lower = tapply (df.2$value, 
                                                            df.2$variable, quantile, probs = c(0.01), na.rm = TRUE))

ns <- subset (low.quan, lower > 0.01)

df.2 <- subset (df.2, df.2$variable %in% ns$factor)

rm (low.quan, ns)

df <- df.2

gg <- ggplot (df, aes (x = df$variable, y = value, colour = df$variable)) +
  geom_boxplot(notch = TRUE, show.legend = FALSE) + 
  labs (title = "Total Effects", x = "Model Factor", y = expression ("S"["i"]))

gg
