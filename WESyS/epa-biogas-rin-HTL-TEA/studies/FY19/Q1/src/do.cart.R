#D.Inman
#Nov 15 2018
#this function performs CART on a tidy dataset and prunes the regtree based on MSE

do.cart <- function (df, cp = NULL){
  
  tryCatch (
    {
  data <- df
  fit.1 <-  (rpart (V2 ~ ., data, method = "anova", cp = 0.025))
  cart.results <- summary (fit.1)
  return (cart.results)
}, 
  error = function (e){
    cart.results = "rpart failed"
  })
}




