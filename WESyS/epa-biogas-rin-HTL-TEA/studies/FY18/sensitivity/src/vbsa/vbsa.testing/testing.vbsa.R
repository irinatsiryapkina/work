#vbsa trouble shooting
#fake data, fake model
#D.Inman 03212018

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

# Set parameters
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/vbsa.testing/")

#load functions
source ("../vbsa.functions.R")
source ("../scratch/old.vs.new.R")

# generate data for 5 factors - this will be the basis of our model
foo <- data.table (f1 = runif(n = 1000, min = 1, max = 6000), f2 = rnorm (n = 1000, sd = 50, mean = 125), 
                   f3 = seq (from = 3001, to = 4000, by = 1) + rnorm (n = 1000, sd = 150, mean = 3500), 
                   f4 = seq (from = 0.001, to = 1, by = 0.001),
                   f5 = rpois (1000, 5), f6 = seq (from = 3001, to = 4000, by = 1) + rpois (1000, 10000))
                  

foo.model <- lm (f4 ~ ., data = foo)
summary (foo.model)
plot (foo)

#now generate an sobol qrs study for foo.model

study.vars <- read.csv ("foo.config.csv", header = TRUE, fileEncoding = "UTF-8-BOM")

study.vars$delta <- study.vars$max - study.vars$min

vbsa.seed <- set.seed(12340)

# Set factors to study.vars 
factors <- study.vars
factors$set <- seq (from = 1, to = nrow(factors))
k <- nrow(study.vars)   # number of factors
N <- 5000

qrs <- randtoolbox::sobol(N, dim = 2*k, seed = vbsa.seed)  

# Separate sequence into A and B matrices, each (N x factors)
A <- qrs[,1:k]
B <- qrs[,(k+1):(2*k)]

# Create C matrices
# For each factor, C = matrix B with column i taken from matrix A
C.runs <- matrix(nrow = N*k, ncol = k)

for(i in 1:k){
  print(i)
  C <- B
  C[,i] <- A[,i]
  C.runs[((i-1)*N+1):(i*N),] <- C
}

# Create D matrices
# For each factor, D = matrix A with column i taken from matrix B
D.runs <- matrix(nrow = N*k, ncol = k)

for(i in 1:k){
  print(i)
  D <- A
  D[,i] <- B[,i]
  D.runs[((i-1)*N+1):(i*N),] <- D
}

# Combine matrices
runs <- rbind(A, B, C.runs, D.runs) 

# Transform data; each column represents a unique Variable + Subscript 1 + Subscript 2 + Index
#combination.  Rows represent the individual runs.
a <- t(factors$set)
b <- 1 : dim(runs)[2]
z <- matrix(a, nrow = length(b), ncol = length(a), byrow = TRUE)
zz <- apply(b == z, c(1,2), function(x) {if (x) 1 else 0})
w <- runs %*% zz

# Take result and put into model format
new.design <- w * matrix(factors$delta, nrow = dim(runs)[1], ncol = length(a), 
                         byrow = TRUE) + matrix(factors$min, nrow = dim(runs)[1], 
                                              ncol = length(a), byrow = TRUE)

colnames (new.design) <- study.vars$factor



vbsa.design <- as.data.table (new.design)

save (vbsa.design, file = "foo.vbsa.design.RDA")

#run study design through model and collect the results

foo.output <- predict.lm (foo.model, vbsa.design, interval = "prediction", type = "response")
foo.output <- as.numeric (foo.output [,1])

#center output by subtracting the mean from output
output.centered <- foo.output - mean(foo.output)

#split total output into A and B vectors (1xN) and C and D matrices (Nxk), see Saltelli 2008 ch. 4
A.out <- output.centered[1:N] # (N x 1)
B.out <- output.centered[(N+1):(N*2)] # (N x 1)

C.out <- matrix(nrow=N, ncol=k)
for(i in 1:k){
  C.out[,i] <- output.centered[((i+1)*N+1):((i+2)*N)]
}

D.out <- matrix(nrow=N, ncol=k)
for(i in 1:k){
  D.out[,i] <- output.centered[((i+1+k)*N+1):((i+2+k)*N)]
}

ABCD <- cbind(A.out, B.out, C.out, D.out)

var.names <- as.character (study.vars$factor)

vbsa.results <- get.sensitivity (ABCD, boots = 10000, vars = var.names)

vbsa.results.2nd <- get.second.order(ABCD, vars = var.names)

####Plot Results #####
#First Order
df.1 <- subset (vbsa.results, index == "S.i")

low.quan <- data.table (factor = var.names, lower = tapply (df.1$value, 
                                                            df.1$variable, quantile, probs = c(0.01), na.rm = TRUE))

ns <- subset (low.quan, lower > 0)

df.1 <- subset (df.1, df.1$variable %in% ns$factor)

rm (low.quan, ns)

#filename = paste( set, "Si.png", sep=".")
#png (file = paste (figurepath, filename, sep = "/"))

df <- df.1

gg <- ggplot (df, aes (x = df$variable, y = value, colour = df$variable)) +
  geom_boxplot(notch = TRUE, show.legend = TRUE) + 
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  labs (title = "First Order Index", x = "Model Factor", y = expression ("S"["i"]))

gg

#Total Effects

df.2 <- subset (vbsa.results, index == "S.t.i")

low.quan <- data.table (factor = var.names, lower = tapply (df.2$value, 
                                                            df.2$variable, quantile, probs = c(0.01), na.rm = TRUE))

ns <- subset (low.quan, lower > 0.01)

df.2 <- subset (df.2, df.2$variable %in% ns$factor)

rm (low.quan, ns)

df <- df.2

gg <- ggplot (df, aes (x = df$variable, y = value, colour = df$variable)) +
  geom_boxplot(notch = TRUE, show.legend = TRUE) + 
    theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank()) +
  labs (title = "Total Effects", x = "Model Factor", y = expression ("S"["i"]))

gg

##compare methods ###
comp.vbsa <- compare.sensitivity(ABCD, 10000, var.names)

###compare to factorial ANOVA
library ("car")
#just a test
foo.study <- cbind (output.centered, vbsa.design)

lm.model <- lm (output.centered ~ f1 + f2 + f3 + f5 + f6, data = foo.study, na.action = "na.fail")

anova.model <- Anova (foo.model, type = "II", p.adjust.methods = TRUE)
anova.df <- as.data.table (anova.model)
setnames (anova.df, c("SS","df", "F", "P.value" ))
anova.df$factor <- row.names (anova.model)
total.ss <- sum (anova.df[1:105, 1]) + anova.df[106,1]
interaction.est <- anova.df[106,1]/total.ss #estimate the %var not explained by the dep var. since this is a deterministic model we can assume this is the remaining interactions
sig.factors <- subset (anova.df, P.value < 0.05)


