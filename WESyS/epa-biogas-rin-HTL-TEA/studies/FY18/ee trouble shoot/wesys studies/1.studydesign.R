#
# Elementary Effects Study Design 
#
rm(list=ls()) # clear workspace
R_LIBS= ("/home/R/library") # set path for R libraries 
options(scipen=999) # turn scientific notation off
options(stringsAsFactors = FALSE) # turn off representing strings as factors

# Set parameters for each study  
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/ee trouble shoot/wesys studies/")

r <- 500 # number of trajectories for EE study 

# Load libraries 
library(sensitivity)
library(gdata)
library (dplyr)
library (data.table)

# 1. Load Excel Input
vars <- read.csv ("ca.500traj.ee.study.design.csv")
vars <- vars[,1:5]
    
vars <- mutate(vars, new.var.names = paste(factor, sep=":"))
vars$delta <- vars$max - vars$min
    
## 2. Generate a Study Design
set.seed(12340)
    
    # Morris 2r sample points per input:
    #     total = r(k + 1) samples, where
    #        k = the number of inputs
    #        r = the number of trajectories (reps)
    #        N = number of factors
N <- nrow(vars)
    
    myGenerate <- function (X){
      rep(1,dim(X)[2])
    }
# Generate the Morris Study Design
SA.design <- morris(model = myGenerate, factors = N, r = r,
                        design = list(type = "oat", levels = 6, grid.jump=1))$X
    
# Save the Morris Study Design
 save(SA.design, file = "sa.design.ca.RDA")
    
    # 3. Transform Data
    #         Each column represents a unique Variable
    #         Rows represent the individual runs.
    a <- t(vars$set)
    b <- 1 : dim(SA.design)[2]
    z <- matrix(a, nrow=length(b), ncol=length(a), byrow=TRUE)
    zz <- apply(b == z, c(1,2), function(x) {if (x) 1 else 0})
    w <- SA.design %*% zz
    
    new.design <- w * matrix(vars$delta, nrow=dim(SA.design)[1], ncol=length(a), byrow=TRUE) + matrix(vars$min, nrow=dim(SA.design)[1], ncol=length(a), byrow=TRUE)
    colnames(new.design) <- vars$new.var.names
    ee.design <- melt(t(new.design))
    colnames(ee.design) <- c("variable", "run", "value")
    
    ## 4. Save Transformed Outputs
    #       # These outputs are inputs for the WESyS model
    
    save (ee.design, file = results_rda_filepath)
}
