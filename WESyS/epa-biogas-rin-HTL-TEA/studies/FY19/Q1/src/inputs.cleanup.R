rm (list = ls()) 

library (data.table)
library (dplyr)
library (RPostgreSQL)
library (dbplyr)
library (rstudioapi)

options (stringsAsFacors = FALSE)
options (scipen = 999)

setwd ("~/GitHub/epa-biogas-rin/studies/FY19/Q1/src/")

data <- read.csv("../../../../data/regional_model/WESyS inputs DRAFT 10172018.csv", header = FALSE)
data <- as.data.table (data)
setnames (data, c("factor", "value"))

data <- data[!grep ("FT", data$factor), ]

write.csv (data, file ="../../../../data/regional_model/WESyS inputs DRAFT 10172018.csv")
