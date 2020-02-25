# 
# Sensitivity Measures for Sensi Index, Total Effects,
# complements of (k-2) order effects (S(-ij)^c), 
# second order closed (S.ij.c) and second order (S.ij) effects
#
# 
# Based on Saltelli, A. (2002). Making best use of model evaluations to 
#         compute sensitivity indices. Computer Physics Communications, 
#         (2), 280-297.
#     Saltelli (2010) Variance based sensitivity analysis of model output. Design and estimator
#           for the total sensitivity index
#     Saltelli (2008) Global Sensitivity Analysis: The Primer

get.sensitivity.new <- function(ABCD, k){
  A <- ABCD[, 1]
  B <- ABCD[, 2]
  C <- ABCD[, 3:(k+2)]
  D <- ABCD[, (k+3):(2*k+2)]

  N <- length(A)
  k <- ncol(C)
  

  #First, total, second order closed, and second order indices
  params <- 2*k + 3*((k-1)*k/2)
   
  sensi <- as.data.frame(matrix(nrow=params, ncol=5))
  colnames(sensi) <- c("variable.i", "variable.j", 
                       "estimate", "est.value", 
                       "est.PE")
  count <- 1
  
  es.y.1 <- mean(A)^2
  var.y.1 <- (A%*%A)/N-es.y.1
  
  es.y.2 <- (A%*%B)/N
  var.y.2 <- (A%*%A)/N-es.y.2
  
  #First Order and Total Effects
  for(i in 1:k){
    sensi$variable.i[count] <- i
    sensi$estimate[count] <- "S.i"
    sensi$est.value[count] <- ((A%*%C[,i])/(N-1)-es.y.2)/var.y.2
    sensi$est.PE[count] <- (1.96/sqrt(N)*sqrt(sum((A*C[,i])^2)/N - (A%*%C[,i]/N)^2))/var.y.2
    count <- count + 1
    
    sensi$variable.i[count] <- i
    sensi$estimate[count] <- "St.i"
    sensi$est.value[count] <- (sum((A-D[,i])^2)/(2*N))/var.y.1
    sensi$est.PE[count] <- (1.96/sqrt(N)*sqrt(sum(((A-D[,i])^2)^2)/(2*N) - (sum((A-D[,i])^2)/(2*N))^2))/var.y.1
    count <- count + 1
    
  } 
  
  #Closed Complement Indices
  for(i in 1:k){
    for(j in (i+1):k){
      if(j>k){
        break
      }
      sensi$variable.i[count] <- i
      sensi$variable.j[count] <- j
      sensi$estimate[count] <- "S._ij.c"
      sensi$est.value[count] <- ((C[,i]%*%C[,j])/(N-1) - es.y.2)/var.y.2
      sensi$est.PE[count] <- (1.96/sqrt(N)*sqrt(sum((C[,i]*C[,j])^2)/N - (C[,i]%*%C[,j]/N)^2))/var.y.2
      count <- count + 1
      
    }
  }
  
    #Second Order Closed and Second Order Indices
    for(i in 1:k){
      
      Vi <- (A%*%C[,i])/(N-1)-es.y.2
      
      for(j in (i+1):k){
        if(j>k){
          break
        }
        
        Vj <- (A%*%C[,j])/(N-1)-es.y.2
        
        Vij.c <- ((C[,i]%*%D[,j])/(N-1) - es.y.2) 
        
        sensi$variable.i[count] <- i
        sensi$variable.j[count] <- j
        sensi$estimate[count] <- "S.ij.c"
        sensi$est.value[count] <- Vij.c/var.y.2
        sensi$est.PE[count] <- (1.96/sqrt(N)*sqrt(sum((C[,i]*D[,j])^2)/N - (C[,i]%*%D[,j]/N)^2))/var.y.2
        count <- count + 1
        
        sensi$variable.i[count] <- i
        sensi$variable.j[count] <- j
        sensi$estimate[count] <- "S.ij"
        sensi$est.value[count] <- (Vij.c-Vi-Vj)/var.y.2
        sensi$est.PE[count] <- NA
        count <- count + 1
        
      }
    }

  return(sensi)
}


#function to be used for bootstrapping
boot.vbsa <- function (abcd.matrix, size, k) {
  boot.sample <- abcd.matrix [sample (nrow (abcd.matrix), size = size, replace = TRUE),]
  A.boot <- boot.sample [,1]
  B.boot <- boot.sample [,2]
  C.boot <- boot.sample [,3:(k+2)]
  D.boot <- boot.sample [,(k+3):(2*k+2)]
  sensi <- get.sensitivity.new(A.boot, B.boot, C.boot, D.boot)
  return (sensi$est.value)
}


get.first.order <- function(ABC, k, boots){
  A <- ABC[, 1]
  B <- ABC[, 2]
  C <- ABC[, 3:(k+2)]
  
  N <- length(A)
  k <- ncol(C)
  
  #params <- 2*k + 3*((k-1)*k/2)
  params <- k
  #sensi <- matrix (nrow = params, ncol = 1)
  #colnames (sensi) <- c("Si")
  
  #count <- 1
  ##################################
  #es.y.1 <- mean(A)^2 #bootstrap this
  
  #have to make a new function that uses the built-in index "i"
  #note this does not square the mean in the function
  mean.new <- function (x, i){
    x2 <- mean (x[i])
    return (x2)
  }
  
  df.mn <- boot (data = A, statistic = mean.new, R = boots, stype = "i",
                 sim = "ordinary")
  
  es.y.1.boot <- df.mn$t      
  
  
  ################################
  #var.y.1 <- (A%*%A)/N-es.y.1 #note that this is pop var #bootstrap this
  #make a new function for    
  var.new <- function (x, i){
    x2 <- x[i]
    return (var (x2))
  }
  
  df.vr <- boot (data = A, statistic = var.new, R = boots, stype = "i",
                 sim = "ordinary")
  
  var.y.1.boot <- df.vr$t
  
  ############################
  #es.y.2 <- (A%*%B)/N
  #make a bootstrappable function
  cov.new <- function (X, i){
    x <- X[i, 1]
    y <- X[i, 2]
    return (cov (x, y))
  }
  
  df.cv <- boot (data = cbind(A,B), statistic = cov.new, R = boots, stype = "i",
                 sim = "ordinary")
  
  es.y.2.boot <- df.cv$t
  
  ##############
  #var.y.2 <- (A%*%A)/N-es.y.2
  
  #use bootstrapped datasets for this
  dot.A <- A%*%A
  
  dot.A.n <- as.numeric (dot.A/N)
  
  var.y.2.boot <- dot.A.n - es.y.2.boot[,1]
  
  #First Order 
  sensi <- matrix (ncol = k, nrow = boots)
  for(i in 1:k){
    sensi [,i] <- ((as.numeric (A%*%C[,i])/(N-1)) - es.y.2.boot)/var.y.2.boot
  } 
  
  return(sensi)
}

get.first.order <- function(ABC, k, boots){
  A <- ABC[, 1]
  B <- ABC[, 2]
  C <- ABC[, 3:(k+2)]
  
  N <- length(A)
  k <- ncol(C)
  
  #params <- 2*k + 3*((k-1)*k/2)
  params <- k
  #sensi <- matrix (nrow = params, ncol = 1)
  #colnames (sensi) <- c("Si")
  
  #count <- 1
  ##################################
  #es.y.1 <- mean(A)^2 #bootstrap this
  
  #have to make a new function that uses the built-in index "i"
  #note this does not square the mean in the function
  mean.new <- function (x, i){
    x2 <- mean (x[i])
    return (x2)
  }
  
  df.mn <- boot (data = A, statistic = mean.new, R = boots, stype = "i",
                 sim = "ordinary")
  
  es.y.1.boot <- df.mn$t      
  
  
  ################################
  #var.y.1 <- (A%*%A)/N-es.y.1 #note that this is pop var #bootstrap this
  #make a new function for    
  var.new <- function (x, i){
    x2 <- x[i]
    return (var (x2))
  }
  
  df.vr <- boot (data = A, statistic = var.new, R = boots, stype = "i",
                 sim = "ordinary")
  
  var.y.1.boot <- df.vr$t
  
  ############################
  #es.y.2 <- (A%*%B)/N
  #make a bootstrappable function
  cov.new <- function (X, i){
    x <- X[i, 1]
    y <- X[i, 2]
    return (cov (x, y))
  }
  
  df.cv <- boot (data = cbind(A,B), statistic = cov.new, R = boots, stype = "i",
                 sim = "ordinary")
  
  es.y.2.boot <- df.cv$t
  
  ##############
  #var.y.2 <- (A%*%A)/N-es.y.2
  
  #use bootstrapped datasets for this
  dot.A <- A%*%A
  
  dot.A.n <- as.numeric (dot.A/N)
  
  var.y.2.boot <- dot.A.n - es.y.2.boot[,1]
  
  #First Order 
  sensi <- matrix (ncol = k, nrow = boots)
  for(i in 1:k){
    sensi [,i] <- ((as.numeric (A%*%C[,i])/(N-1)) - es.y.2.boot)/var.y.2.boot
  } 
  
  return(sensi)
}





