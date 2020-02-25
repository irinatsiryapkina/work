#A. Eberle
#Dec 19 2018
#New visualizations for CART analysis of Q1 HTL study

# run cart first then use the fit for plotting here 
source("cart.R")

y <- fit$frame$yval
if(low.is.green)
  y <- -y
max <- max(y)
min <- min(y)
cols <- rainbow(99, start=0.02, end=.32, s=0.5)[
  ifelse(y > y[1], (y-y[1]) * (99-50) / (max-y[1]) + 50,
         (y-min) * (50-1) / (y[1]-min) + 1)]

name_list = list("root", 
"Initial commercial maturity of HTL < 0.85" ,
"Initial commercial maturity of HTL >= 0.85",
"RIN multiplier < 1.5"                ,
"RIN multiplier < 0.82"               ,
"RIN multiplier >= 0.82"              ,
"Disposal cost < 320"                  ,
"Disposal cost >= 320"                 ,
"Construction duration multiplier >= 0.53",                
"Construction duration multiplier < 0.53"  ,               
"RIN multiplier >= 1.5"               ,
"Construction duration multiplier >= 0.58",                
"Construction duration multiplier < 0.58"  ,               
"Disposal cost < 113"                  ,
"Disposal cost >= 113"                 ,
"PTC REC multiplier >= 0.23"          ,
"PTC REC multiplier < 0.23")


split.fun <- function(x, labs, digits, varlen, faclen)
{
  print(x)
  print(labs)
  # replace commas with spaces (needed for strwrap)
  labs <- gsub(",", " ", labs)
  for(i in 1:length(labs)) {
    # split labs[i] into multiple lines
    # name <- strsplit(labs[i], '[.]')[[1]][2]
    # if (is.na(strsplit(labs[i], '[.]')[[1]][3]) == FALSE) {
    #   dec <- strsplit(labs[i], '[.]')[[1]][3]
    #   name <- paste(name, dec, sep=".")
    # }
    # labs[i] <- name
    
    # test1 <- ((labs[i] == "Initial Indices of Comm Maturity[HTL] < 0") == TRUE)
    # if (is.na(test1) == FALSE) {
    #   if (test1 == TRUE) {
    #     labs[i] <- "Initial commercial maturity of HTL < 0"  
    #   }
    # }
    #labs[i] <- name_list[[i]]
    labs[i] <- paste(strwrap(labs[i], width = 30), collapse = "\n")
  }
  labs
}
prp(fit, extra=1, type=2, gap=0, compress=TRUE, ycompress=TRUE, prefix='Avg. GJ HTL=', under=F, box.col=cols, split.fun=split.fun, varlen=0, digits=2, roundint=FALSE)



# path.to.root <- function(node)
# {
#   if(node == 1) # root?
#     node
#   else # recurse, %/% 2 gives the parent of node
#     c(node, path.to.root(node %/% 2))
# }
# node <- 63 # 11 is our chosen node, arbitrary for this example
# nodes <- as.numeric(row.names(fit$frame))
# cols <- ifelse(nodes %in% path.to.root(node), "forestgreen", "#A7A7A7")
# 
# prp(fit, extra=1, type=1, gap=0, compress=TRUE, ycompress=TRUE, prefix='Avg. GJ HTL=', under=F, branch.col=cols, col=cols, split.col=cols, branch.type=0, yesno=TRUE, faclen=0)
