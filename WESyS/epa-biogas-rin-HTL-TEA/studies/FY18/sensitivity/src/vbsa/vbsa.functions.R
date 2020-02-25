get.sensitivity <- function(ABCD, boots, vars){
  k <- length (vars)
  
  A <- ABCD[, 1]
  B <- ABCD[, 2]
  C <- ABCD[, 3:(k+2)]
  D <- ABCD[, (k+3): ncol (ABCD)]
  
  N <- length(A)
 
  var.names <- vars
  ##################################
  #es.y.1 <- mean(A)^2 #bootstrap this
      #mean.new <- function (x, i){
        #x2 <- mean (x[i])
        #return (x2)
        #}
  
  #df.mn <- boot (data = A, statistic = mean.new, R = boots, stype = "i",
                   #sim = "ordinary")
        
  #es.y.1.boot <- df.mn$t      
          
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
      
 #First Order 
      first.order <- matrix (ncol = k, nrow = boots)
      for(i in 1:k){
        first.order [,i] <- ((as.numeric (A%*%C[,i])/(N-1)) - es.y.2.boot)/var.y.2.boot
        first.order <- as.data.table (first.order)
      } 
      
      setnames (first.order, var.names)
      first.order <- melt (first.order, measure.vars = colnames (first.order))
      first.order$index <- "S.i"
     
#Total Effects
      total.effects <- matrix (ncol = k, nrow = boots)
      for(i in 1:k){
        total.effects [,i] <- (sum((A - D[,i])^2)/(2 * N))/var.y.1.boot
        total.effects <- as.data.table (total.effects)
       } 
      
      setnames (total.effects, var.names)
      total.effects <- melt (total.effects, measure.vars = colnames (total.effects))
      total.effects$index <- "S.t.i"
     
      sensi <- rbind (first.order, total.effects)
      return (sensi)
      
}

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




