rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off

library (data.table)
library (dplyr)
library (plyr)
library(randtoolbox)
library(sensitivity)
library (boot)
library (ggplot2)

load ("foo.abcd.RDA")
#for this fake dataset:
study.vars <- read.csv ("foo.config.csv", header = TRUE, fileEncoding = "UTF-8-BOM")
vars <- as.character (study.vars$factor)
# Set factors to study.vars 
#factors <- study.vars
k <- nrow(study.vars)   # number of factors
N <- 5000


get.second.order <- function(ABCD, vars){
  k <- length (vars)
  A <- ABCD[, 1]
  B <- ABCD[, 2]
  C <- ABCD[, 3:(k+2)]
  D <- ABCD[, (k+3):(2*k+2)]
  
  N <- length(A)
  
  var.names <- as.character (vars)
  #var.names <- study.vars$factor
  
  #First, total, second order closed, and second order indices
  params <- ((k-1) * k/2) #for second order, nrows = gaussian sum to k
  
  sensi <- as.data.frame (matrix (nrow = params, ncol = 4))
  colnames(sensi) <- c("variable.i", "variable.j", "upper", "lower") 
  
  count <- 1
  
  es.y.1 <- mean(A)^2
  var.y.1 <- (A%*%A)/N-es.y.1
  
  es.y.2 <- (A%*%B)/N
  var.y.2 <- (A%*%A)/N-es.y.2
  
  #Second Order 
  for(i in 1:k){
    
    Vi <- (A%*%C[,i])/(N-1)-es.y.2
    
    for(j in (i+1):k){
      if(j>k){
        break
      }
      
      Vj <- (A%*%C[,j])/(N-1)-es.y.2
      
      Vij.c <- ((C[,i]%*%D[,j])/(N-1) - es.y.2) 
      
      
      sensi$variable.i[count] <- var.names [i]
      sensi$variable.j[count] <- var.names [j]
      
      sensi$est.value[count] <- (Vij.c-Vi-Vj)/var.y.2
      sensi$upper[count] <- ((Vij.c-Vi-Vj)/var.y.2) + ((1.96/sqrt(N)*sqrt(sum((C[,i]*D[,j])^2)/N - 
                                                                            (C[,i]%*%D[,j]/N)^2))/var.y.2)
      sensi$lower[count] <- ((Vij.c-Vi-Vj)/var.y.2) - ((1.96/sqrt(N)*sqrt(sum((C[,i]*D[,j])^2)/N - 
                                                                            (C[,i]%*%D[,j]/N)^2))/var.y.2)
      count <- count + 1
      
    }
  }
  
  return(sensi)
}

sensi <- get.second.order(ABCD, study.vars$factor)

sensi$comb <- paste (sensi$variable.i, sensi$variable.j, sep = " & ")

# Sij
df <- sensi



gg <- ggplot(df, aes(x = df$comb, ymin = df$lower, lower = df$lower, middle = df$est.value, 
                       upper = df$upper, ymax = df$upper)) 
      
      gg + geom_boxplot(stat = "identity")


