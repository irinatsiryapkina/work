rm(list=ls())
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")
#setwd ("~/wte")
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)

# Load libraries
library (dplyr)
library (data.table)
library (sensitivity)
library (randtoolbox)
library (gdata)
library (plyr)

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


batch.ee <- function (x,y,n,r){
  result <- ee (x,y,n,r)
  return (result)
}


#load ("ca.sludge.2000traj.2040.RDA")

load ("ca.biogas.2000traj.2040.RDA")

load ("sa.design.ca.2000traj.RDA")

vars <- read.csv("ca.2000traj.ee.study.design.csv", header = TRUE)
vars <- vars[,1:5]

# Run EE 
r = 2000
N = 674


dat <- data.2040

dat.split <- split (dat, dat$factor) #create a list of datatables by factor


LIST <- list ()
for (i in 1:length (dat.split)){
  print(i)
  LIST [[i]] <- batch.ee (SA.design, dat.split[[i]]$value, N, r)
  LIST [[i]] <- join (vars, LIST[[i]], by="set")
  LIST [[i]] <- arrange (LIST[[i]], desc(std.errors))
  ee.results <- (LIST)
}

names (ee.results) <- names (dat.split)

save (ee.results, file = ee.results.ca.sludge.2000traj.wesys.RDA)

sig.factors <- lapply (ee.results, function (x) subset (x, std.errors < 2))
save (sig.factors, file = output_sig_type_filepath)

