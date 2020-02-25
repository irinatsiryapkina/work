rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")

# Load libraries 
library (dplyr)
library (data.table)


# Elementary Effects Function 1: ee
# **** DESCRIPTION HERE *****
ee.test <- function(x = NULL, y = NULL, N = NULL, r = NULL) {
  y = y - min(y)
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

list.files("results/")
load ("sa.design.ca.2000traj.RDA")
vars <- read.csv ("designs/ca.2000traj.ee.study.design.csv")
vars <- vars [,2:5]

load ("ee.ca.2000traj.wesys.results.RDA")

data.2040 <- out [grep ("WWTP", out$factor), ] 
data.2040 <- data.2040 [!grep ("FT", data.2040$factor), ]
data.2040 <- data.2040 [!grep ("Fuel", data.2040$factor), ]
data.2040 <- data.2040 [!grep ("total", data.2040$factor), ] #just the total production for each individual pathway
data.2040 <- data.2040 [grep ("tot", data.2040$factor), ] #just the total production
data.2040$value <- as.integer(data.2040$value)


df <- unique(data.2040)
total.prod <- df[, sum(value), by=run_id]
total.prod <- data.table (run_id = total.prod$run_id, factor = "WWTP.total", value = total.prod$V1)
data.2040 <- rbind (df, total.prod)


test.ee <- ee.test (SA.design, total.prod$value, 674, 2000)
