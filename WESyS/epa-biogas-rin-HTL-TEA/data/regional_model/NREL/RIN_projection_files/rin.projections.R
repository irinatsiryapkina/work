#08092017
#D.Inman
#testing out frontier detection appraches

rm (list = ls())
setwd ("~/GitHub/epa-biogas-rin/data/regional_model/OPIS/")

library (data.table)
library (dplyr)
library (forecast)
library (zoo)

rins <- read.table ("rins.csv", header = TRUE, sep = ",", quote = "\"", stringsAsFactors = TRUE)

rins <- data.table (rin.type = rins$Product.Name, year = rins$Vintage, date = rins$Publication.Date, 
                    type = rins$Price.Type, price = rins$Price)
d3 <- subset (rins, rin.type == "Cellulosic RIN")

d3 <- subset (d3, type == "Average")

d3 <- data.table (date = as.Date (d3$date, format = "%m/%d/%Y"), price = d3$price)

str(d3)
 
d3.zoo <- read.zoo (d3, header = TRUE)

#plot (d3.zoo)
#head (d3.zoo)
tail (d3.zoo)

d3.ar <- auto.arima (d3.zoo)

d3.2017.proj <- forecast.Arima (d3.ar,h = 365)

d3.proj <- data.table (date = seq(from = as.Date("2016-08-05"), to = as.Date("2017-08-04"), by = 'day'),
                       mean = d3.2017.proj$mean, low = d3.2017.proj$lower, upper = d3.2017.proj$upper)



write.csv (d3.proj, file = "d3.rin.projected.csv")


