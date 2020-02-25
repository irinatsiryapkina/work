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
      
    #return(list (first.order, total.effects))
}







