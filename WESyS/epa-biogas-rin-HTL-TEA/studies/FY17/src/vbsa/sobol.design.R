# D.Inman
#WESyS Sensitivity Design
#08312017

#set working directory and a directory to dump results
rm(list=ls())
R_LIBS= ("/home/R/library")
setwd ("~/GitHub/epa-biogas-rin/studies/sensitivityFY17/src/vbsa/")
#load pertinent libraries
library (XLConnect)
library(randtoolbox)
library (dplyr)
library (reshape2)
library (data.table)

# load the factor settings. The number of factors in this workbook must match the number of factors above.
#note the filename and sheet number below - check that these are correct
wb <- loadWorkbook("modelsettings.xlsx")
study.vars <- readWorksheet(wb, sheet="NewSetNumbers")
study.vars$delta <- study.vars$Study.Max - study.vars$Study.Min

factors <- study.vars
factors$Set <- seq (from = 1, to = nrow(factors))

###############
# create the sampling space for setting the factors
seed <- 31001 

#our sensitivity study in 2014 showed that N of 2000 - 4000 produced the narrowest BCI for a 19-factor model. 3000 is a conservative estiamte
#study size = 2N(k+1)
N <- 1000  #number of observations
k <- nrow(study.vars)   #number of factors

#generate quasi-random sequence
qrs <- sobol(N, dim=2*k, seed=seed)  

#Separate sequence into A and B matrices, each (N x factors)
A <- qrs[,1:k]
B <- qrs[,(k+1):(2*k)]

#Create C matrices
#For each factor, C = matrix B with column i taken from matrix A
C.runs <- matrix(nrow=N*k,ncol=k)

for(i in 1:k){
  C <- B
  C[,i] <- A[,i]
  C.runs[((i-1)*N+1):(i*N),] <- C
}

#Create D matrices
#For each factor, D = matrix A with column i taken from matrix B
D.runs <- matrix(nrow=N*k,ncol=k)

for(i in 1:k){
  D <- A
  D[,i] <- B[,i]
  D.runs[((i-1)*N+1):(i*N),] <- D
}

#Combine matrices
runs <- rbind( A, B, C.runs, D.runs) 

# 3. Transform data; each column represents a unique Variable + Subscript 1 + Subscript 2 + Index
#combination.  Rows represent the individual runs.
a <- t(factors$Set)
b <- 1 : dim(runs)[2]
z <- matrix(a, nrow=length(b), ncol=length(a), byrow=TRUE)
zz <- apply(b == z, c(1,2), function(x) {if (x) 1 else 0})
w <- runs %*% zz

#take result and put into model format
new.design <- w * matrix(factors$delta, nrow=dim(runs)[1], ncol=length(a), byrow=TRUE) + matrix(factors$Study.Minimum, nrow=dim(runs)[1], ncol=length(a), byrow=TRUE)

new.design <- as.data.table (melt (t(new.design)))

setnames (new.design, c("Subscript.1", "run", "value"))

design.in.model.format <- data.table (variable = factors$Variable.Name, sub1 = factors$Subscript.1, sub2 = factors$Subscript.2, 
                                      sub3 = factors$Subscript.3, run = new.design$run, value = new.design$value)

#add end years to the input sheet
df.1 <- design.in.model.format
starts <- df.1[grep(" Start", df.1$variable), ]
starts <- arrange(starts, variable)
duration <- df.1[grep("Dur", df.1$variable), ]
duration <- arrange(duration, variable)
ends <- cbind(starts, duration$value)
ends <- mutate(ends, end.year = value + duration$value)
ends[] <- lapply(ends, function(x) gsub("Start", "End", x))
ends <- data.table (run = ends$run, variable = ends$variable, sub1 = ends$sub1, sub2 = ends$sub2,
                    sub3 = ends$sub3, value = ends$end.year)
save (design.in.model.format, file = "designs/sobol.design.RDA")
write.csv (design.in.model.format, file = "designs/sobol.design.csv")

#for study designs that have policy on and off years
#colnames (ends) <- c("variable", "run", "value")
#df.1 <- df.1 [!(df.1$variable %in% duration$variable),]

#design.in.model.format.2 <- (rbind (df.1, ends))
#design.in.model.format.2 <-transform(design.in.model.format.2, run = as.numeric(run))
#design.in.model.format.2 <-transform(design.in.model.format.2, value = as.numeric(value))
#design.in.model.format.2 <- arrange(design.in.model.format.2, run)
#df <- design.in.model.format.2
#df$value[df$value > 2051] <- 2051

#design.in.model.format.2 <- df
#write.csv (design.in.model.format.2, file = "te.design.end.year.csv")
#save (design.in.model.format.2, file = "designs/sobol.ends.RDA")# this is the file to pass to Stella
#write.csv (design.in.model.format.2, file = "designs/sobol.ends.csv")
#sanity checks on design
max (design.in.model.format$run)
head (design.in.model.format)
tail (design.in.model.format)

sanity.test <- dcast (design.in.model.format, run ~ variable + sub1 + sub2 + sub3)
summary (sanity.test)

q(save = "no")





