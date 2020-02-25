compare.sensitivity <- function(ABCD, boots, vars){
  k <- length (vars)
  A <- ABCD[, 1]
  B <- ABCD[, 2]
  C <- ABCD[, 3:(k+2)]
  D <- ABCD[, (k+3): ncol (ABCD)]
  N <- length(A)
  var.names <- vars
  var.new <- function (x, i){
            x2 <- x[i]
            return (var (x2))
          }

    df.vr <- boot (data = A, statistic = var.new, R = boots, stype = "i",
                sim = "ordinary")
    var.y.1.boot <- df.vr$t
    cov.new <- function (X, i){
            x <- X[i, 1]
            y <- X[i, 2]
            return (cov (x, y))
          }
      
      df.cv <- boot (data = cbind(A,B), statistic = cov.new, R = boots, stype = "i",
                     sim = "ordinary")
      es.y.2.boot <- df.cv$t
      dot.A <- A%*%A
      dot.A.n <- as.numeric (dot.A/N)
      var.y.2.boot <- dot.A.n - es.y.2.boot[,1]
#First Order new
      first.order <- matrix (ncol = k, nrow = boots)
          for(i in 1:k){
            first.order [,i] <- ((as.numeric (A%*%C[,i])/(N-1)) - es.y.2.boot)/var.y.2.boot
            first.order <- as.data.table (first.order)
            } 
      
      first.order <- as.data.frame (apply (first.order, 2, median))
      first.order <- cbind (var.names, first.order)
      setnames (first.order, c("factor", "new.Si"))
      
 #First Order old
      sensi <- as.data.frame (matrix (nrow = k, ncol = 3))
      colnames(sensi) <- c("factor", "old.Si",
                           "old.St")
      count <- 1
      
      es.y.1 <- mean(A)^2
      var.y.1 <- (A%*%A)/N-es.y.1
      
      es.y.2 <- (A%*%B)/N
      var.y.2 <- (A%*%A)/N-es.y.2
      for(i in 1:k){
        sensi$factor[count] <- var.names [i]
        sensi$old.Si[count] <- ((A%*%C[,i])/(N-1)-es.y.2)/var.y.2
        sensi$old.St[count] <- (sum((A-D[,i])^2)/(2*N))/var.y.1
        count <- count + 1
        
      }
#Total Effects New
      total.effects <- matrix (ncol = k, nrow = boots)
          for(i in 1:k){
            total.effects [,i] <- (sum((A - D[,i])^2)/(2 * N))/var.y.1.boot
            total.effects <- as.data.table (total.effects)
           } 
      total.effects <- as.data.frame (apply (total.effects, 2, median))
      total.effects <- cbind (var.names, total.effects)
      setnames (total.effects, c("factor", "new.St"))

      results <- data.table (factor = var.names, new.Si = first.order$new.Si,
               old.Si = sensi$old.Si, new.St = total.effects$new.St, old.St = sensi$old.St)

return (results)
}