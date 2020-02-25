#04052018
#MCF with AD k comparisons scratching
#data cave prototyping

rm(list=ls())
R_LIBS= ("/home/R/library")

library (data.table)
library (dplyr)
library (kSamples)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/")

#Functions
get.cdf <- function (numeric.variable, df) {
  Fn <- ecdf (numeric.variable)
  return (knots (Fn))
}

#load the study design
load ("foo.vbsa.design.RDA")

load ("foo.data.RDA")

foo.sobol.output <- as.data.table (foo.sobol.output)

#design <- melt (vbsa.design, id.vars = "run_id")

#create some relationship form the foo data. this mimics a result and some factor that is a function of result like roi

#out <- data.table (run_id = seq (from = 1, to = nrow (foo.sobol.output), by = 1), 
                   #result = abs(foo.sobol.output))
                   
#out$vbl <- (out$result + runif (6000, -.01,.1))^ 0.5
            
#plot (out$vbl, out$result, col = "light grey")

#save (out, file = "foo.data.RDA")

#load study results

#output.centered <- data.table (run_id = out$run_id, result = out$result - mean(out$result),
                               #vbl = out$roi - mean(out$roi))
#out <- output.centered

#out$result <- out$result/max(out$result)

#out$vbl <- out$vbl/max(out$vbl)


#plot some relationship and select a set of interest (B group)
plot (out$vbl, out$result, col = "light grey")


#selection
B <- subset (out, out$vbl > 3.17 & out$result > 9.95)

points (B$vbl, B$result, col = "red")

#subset the study design based on B
B <- subset(design, design$run_id %in% B$run_id)
B <- setorder (B, variable)
B.list <- split(B, B$variable)
B.names <- as.character (unique (B$variable))

#get the cumulative dist function for B
LIST <- list ()
for (i in 1: length(B.list)) {
  LIST [[i]] <- get.cdf (B.list[[i]]$value, B.list[[i]])
  B.cdf <- LIST
}
names (B.cdf) <- B.names #apply the vbl names to the list elements

#Bbar are all other model runs
B.bar <- design [ !(design$run_id %in% B$run), ]#this creates the Bbar by subtracting B from the design
B.bar.sorted <- setorder (B.bar, variable)
B.bar.list <- split(B.bar.sorted, B.bar.sorted$variable)
B.bar.names <- as.character (unique (B.bar.sorted$variable))

#get the cumulative dist function for Bbar
LIST <- list ()
for (i in 1:length (B.bar.list)) {
  LIST [[i]] <- get.cdf (B.bar.list[[i]]$value, B.bar.list[[i]])
  B.bar.cdf <- LIST
}
names (B.bar.cdf) <- B.bar.names#apply the vbl names to the list elements

#perform Anderson-Darling test to compare B to Bbar. H0 = B and Bbar are from the same population; H1 = B and Bbar are not from the same population
#pvalues are based on bootstraps
LIST <- list()  
for (i in 1:length (B.cdf)){
  LIST [[i]] <- ad.test (B.cdf[[i]], B.bar.cdf[[i]], method = "simulated", Nsim = 5) #Nsim = bootstraps
  ad.list <- (LIST)  
}
names (ad.list) <- B.names

LIST <- list()
for (i in 1:length (ad.list)) {
  LIST [[i]] <- ad.list[[i]]$ad[1,4]
  test.results <- (LIST)
}

ad.results <- as.data.table (do.call (rbind, test.results)) #this takes the list elements from AD results and assembles them as a datatable

ad.results <- cbind (B.names, ad.results) #put the factor names in. Need to be careful here to make sure the order did not change
setnames(ad.results, c("factor", "sim.p.value")) 
#need to add a summary of the input ranges to the above datatable

sig.results <- subset (ad.results, ad.results$sim.p.value < 0.01)#subset the AD results based on p-value

test <- subset (B, variable %in% sig.results$factor)

setorder (test, run_id, variable)

test.2 <- tapply (test$value, test$variable, summary)

test.3 <- as.data.table (do.call (rbind, test.2))

#save(ad.results, sig.results, B.list, B.bar.list, B.cdf, B.names, file = paste (results.path,"AD.results.RDA", sep="/"))


# local sensitivity analysis
# define behavioural (B) and non-behavioral (B.bar) sets to test for significant diff in their input settings
