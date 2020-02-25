#testing new sensi functions and bootstrapping
#using bsm study 1006 as an example
rm(list=ls())

library (dplyr)
library (data.table)
library (boot)
library (ggplot2)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/")
source ("vbsa.functions.R")
options(scipen=999)
# Load data and set following parameters

load ("scratch/foo.design.RDA") #design
#load the model output data
load ("scratch/foo.output.RDA")#model input for study 
output <- chc.prod.2045$total

# Get Study Design Settings
new.design <- dcast (foo.design, run ~ variable + sub1 + sub2)
var.names <- c(colnames (new.design [, -c(1)]))
k <- as.numeric (length (unique (var.names)))
N <- as.numeric (max (foo.design$run)/(2*k))

#center output by subtracting the mean from output
output.centered <- output - mean(output)

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

#calculate sens indicies

sensitivity.results <- get.sensitivity (ABCD, boots = 50000, vars = var.names)

sensitivity.results.2 <- get.second.order(ABCD, vars = var.names)
#compare old vs new VBSA results
#source ("scratch/old.vs.new.R")

#comparison <- compare.sensitivity (ABCD, 5000, var.names)

#save (sensitivity.results, file = "sensitivity.results.RDA")

#First Order
df.1 <- subset (sensitivity.results, index == "S.i")

low.quan <- data.table (factor = var.names, lower = tapply (df.1$value, 
            df.1$variable, quantile, probs = c(0.01), na.rm = TRUE))

ns <- subset (low.quan, lower > 0)

df.1 <- subset (df.1, df.1$variable %in% ns$factor)

rm (low.quan, ns)

#filename = paste( set, "Si.png", sep=".")
#png (file = paste (figurepath, filename, sep = "/"))

df <- df.1

gg <- ggplot (df, aes (x = df$variable, y = value, colour = df$variable)) +
  geom_boxplot(notch = TRUE, show.legend = FALSE) + 
  labs (title = "First Order Index", x = "Model Factor", y = expression ("S"["i"]))

gg

#Total Effects

df.2 <- subset (sensitivity.results, index == "S.t.i")

low.quan <- data.table (factor = var.names, lower = tapply (df.2$value, 
            df.2$variable, quantile, probs = c(0.01), na.rm = TRUE))

ns <- subset (low.quan, lower > 0)

df.2 <- subset (df.2, df.2$variable %in% ns$factor)

rm (low.quan, ns)

df <- df.2

gg <- ggplot (df, aes (x = df$variable, y = value, colour = df$variable)) +
      theme (axis.text.x = element_text (angle = 75, hjust = 1)) +
      geom_boxplot(notch = TRUE, show.legend = FALSE) + 
      labs (title = "Total Effects Index", x = "Model Factor", y = expression ("St"["i"]))

gg

# Second Order Effects
df <- sensitivity.results.2
df <- subset (df, df$lower > 0)
df <- arrange (df, -df$est.value)
df <- df[1:10,] #just for plotting purposes 
df$comb <- paste (df$variable.i, df$variable.j, sep = " & ")

gg <- ggplot(df, aes(x = df$comb, colour = df$comb, ymin = df$lower, lower = df$lower, middle = df$est.value, 
                     upper = df$upper, ymax = df$upper)) +
  theme (axis.text.x = element_text (angle = 75, hjust = 1, size = 8)) +
  labs (title = "Second Order Index", x = "Model Factors", y = expression ("S"["ij"])) +
  geom_boxplot(stat = "identity", show.legend = FALSE)

gg





