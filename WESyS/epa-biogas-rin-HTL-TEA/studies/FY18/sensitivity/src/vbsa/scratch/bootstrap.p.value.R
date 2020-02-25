#D.Inman
#asymetric p-value example

rm(list=ls())

library (dplyr)
library (data.table)
library (boot)
library (exactRankTests)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/scratch")

foo.data <- as.data.table (read.csv ("foo.csv"))

summary (foo.data)

foo.test <- t.test (foo.data$R, foo.data$NR, conf.level = 0.95, alternative = "two.sided")

foo.test

foo.test.2 <- wilcox.exact (foo.data$R, foo.data$NR, conf.level = 0.95, alternative = "two.sided")

foo.test.2

boots <- 9999

LIST <- list()
  for (i in 1:boots){
    x <- sample (foo.data$R, size = length (foo.data$R), replace = TRUE)
    y <- sample (foo.data$NR, size = length (foo.data$NR), replace = TRUE)
    LIST [[i]] <- t.test (x, y, conf.level = 0.95, alternative = "two.sided")
    t.results <- LIST
  }

LIST <- list()
for (i in 1:boots){
  x <- sample (foo.data$R, size = length (foo.data$R), replace = TRUE)
  y <- sample (foo.data$NR, size = length (foo.data$NR), replace = TRUE)
  LIST [[i]] <- wilcox.exact (x, y, conf.level = 0.95, alternative = "two.sided")
  wilcox.results <- LIST
}

LIST <- list ()
for (i in 1: length (wilcox.results)){
  LIST [[i]] <- data.table (p = wilcox.results[[i]]$p.value)
  wilcox.p <- do.call (rbind, LIST)
}

LIST <- list ()
for (i in 1: length (t.results)){
  LIST [[i]] <- data.table (x =t.results[[i]][[5]][1], y = t.results[[i]][[5]][2])
  new.results <- do.call (rbind, LIST)
}

results <- cbind(new.results, wilcox.p)

results$rescale.p <- -log10 (results$p)

summary (results)

hist (results$p)#look at the p under null 

hist (results$rescale.p) #use -log base 10 and replot

se <- function (x, i){
  result <- sd(x)/sqrt (length(x))
  return (result)
}


sd (results$rescale.p)
sd (results$p)

boot (results$rescale.p, sd, 10000)
