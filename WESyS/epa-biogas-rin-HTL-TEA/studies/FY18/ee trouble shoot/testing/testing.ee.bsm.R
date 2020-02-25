#EE trouble shooting
#fake data, fake model
#D.Inman 08092018

rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off

library (data.table)
library (dplyr)
#library (plyr)
library(sensitivity)

# Set parameters
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/ee trouble shoot/testing/")

#functions
ee <- function(x = NULL, y = NULL, N = NULL, r = NULL) {
  m <- (N + 1) * r
  xdiff <- (x[2:m, ] - x[1:(m-1), ])[-(N+1)*1:(r-1), ]
  delta <- t(xdiff)[t(xdiff) != 0]
  ydiff <- (y[2:m] - y[1:(m-1)])[-(N+1)*1:(r-1)]
  index <- rep(0:(r-1)*(N + 1), each=N) + apply(xdiff, 1, function(x) (1:N)[x != 0])
  sort.index <- arrange(data.frame(x1 = ydiff, x2 = delta, y = index), index)
  ratio <- matrix(sort.index$x1 / sort.index$x2, nr = N)
  mu <- apply(ratio, 1, mean)
  mu.star <- apply(ratio, 1, function(x) mean(abs(x)))
  sigma <- apply(ratio, 1, sd)
  sem <- sigma/(r^0.5)
  std.e <- abs(mu)/(sigma/(r^0.5))
  data.frame(set=1:N, mu = mu, mu.star = mu.star, sigma = sigma, sem =sem, std.errors = std.e)
}

scale01 <- function(x){(x-min(x))/(max(x)-min(x))} #rescales a vector to (0,1)

#now generate an OAT study for foo.model

vars <- read.csv ("bsm.config.csv", header = TRUE)

setnames (vars, c("set", "factor", "min", "max", "value"))
#vars <- mutate(vars, new.var.names = paste(factor, sep=":"))
vars$delta <- vars$max - vars$min

## 2. Generate a Study Design
set.seed(12340)

# Morris 2r sample points per input:
#     total = r(k + 1) samples, where
#        k = the number of inputs
#        r = the number of trajectories (reps)
#        N = number of factors

N <- nrow(vars)
r = 141

myGenerate <- function (X){
  rep(1,dim(X)[2])
}
# Generate the Morris Study Design
SA.design <- morris(model = myGenerate, factors = N, r = r,
                    design = list(type = "oat", levels = 6, grid.jump=1))$X

# Save the Morris Study Design
#save(SA.design, file = "sa.foo.RDA")

# 3. Transform Data
#         Each column represents a unique Variable
#         Rows represent the individual runs.
a <- t(vars$set)
b <- 1 : dim(SA.design)[2]
z <- matrix(a, nrow=length(b), ncol=length(a), byrow=TRUE)
zz <- apply(b == z, c(1,2), function(x) {if (x) 1 else 0})
w <- SA.design %*% zz

new.design <- w * matrix(vars$delta, nrow=dim(SA.design)[1], ncol=length(a), byrow=TRUE) + matrix(vars$min, nrow=dim(SA.design)[1], ncol=length(a), byrow=TRUE)
colnames(new.design) <- vars$factor
new.design <- as.data.table (new.design) #has to be in wide format for predict.lm to work

###for testing the new scaling EE
#ee.design <- melt(t(new.design))
#colnames(ee.design) <- c("variable", "run", "value")
###


#run study design through model and collect the results
output <- load ("bsm.out.rda")

out <- out[,2]

ee.results.2 <- ee (SA.design, out, N, r, scale = FALSE)

