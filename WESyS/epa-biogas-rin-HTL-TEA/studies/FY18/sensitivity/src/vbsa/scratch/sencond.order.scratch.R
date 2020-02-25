#for testing ############
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
# Set factors to study.vars 
factors <- study.vars
k <- nrow(study.vars)   # number of factors
N <- 5000
boots <- 100
########################

#get.second.order <- function(ABCD, k, boots, vars){
  A <- ABCD[, 1]
  B <- ABCD[, 2]
  C <- ABCD[, 3:(k+2)]
  D <- ABCD[, (k+3): ncol (ABCD)]
  
  #N <- length(A)
  #k <- ncol(C)
  
  params <- k
  
  #var.names <- vars
  var.names <- study.vars$factor
  ##################################
  #es.y.1 <- mean(A)^2 #bootstrap this
      mean.new <- function (x, i){
        x2 <- mean (x[i])
        return (x2)
        }
  
  df.mn <- boot (data = A, statistic = mean.new, R = boots, stype = "i",
                   sim = "ordinary")
        
  es.y.1.boot <- df.mn$t      
          
    ################################
      var.new <- function (x, i){
            x2 <- x[i]
            return (var (x2))
          }

    df.vr <- boot (data = A, statistic = var.new, R = boots, stype = "i",
                sim = "ordinary")
    
    var.y.1.boot <- df.vr$t

############################
        cov.new <- function (X, i){
            x <- X[i, 1]
            y <- X[i, 2]
            return (cov (x, y))
          }
      
      df.cv <- boot (data = cbind(A,B), statistic = cov.new, R = boots, stype = "i",
                     sim = "ordinary")
      
      es.y.2.boot <- df.cv$t

##############
      dot.A <- A%*%A
      
      dot.A.n <- as.numeric (dot.A/N)
      
      var.y.2.boot <- dot.A.n - es.y.2.boot[,1]
      
#Second Order Indices
      Vi <- matrix (nrow = k, ncol = 1)
      Vj <- matrix (nrow = k, ncol = 1)
      
      Vij <- matrix (ncol = (ncol (C) * ncol (D)), nrow = boots)
      
      for (i in 1:k) {
        
        Vi [i,] <- ((A%*%(C[,i])/(N - 1) - es.y.2.boot
      }
        
      for (j in (i + 1):k) {
          
          if (j > k) {
            break
          }
          
          Vj [i,] <- ((B%*%(D[,j]) - A))/N

        }
      ###############
      
      B%*%(D[,2])
      Vi <- (A%*%C[,i])/(N-1)-es.y.2
      
      ################
          
      
      Vij [,i] <- ((D[,i]%*%C[,j])/(N-1) - es.y.2.boot [,1])
          
        }
        
          second.order <- matrix (ncol = ncol(C) * ncol(D), nrow = boots)         

          second.order [,i] <- (Vij[,i]  - Vi[,i] - Vj[,j])/var.y.2.boot
          
        }



          