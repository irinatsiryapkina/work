library (XLConnect)
library (Amelia)
library (dplyr)
library (data.table)
setwd ("C:/Users/dinman/Documents/GitHub/epa-biogas-rin/data/src")
wb <- loadWorkbook ("EPA data.xlsx")
per.cap <- readWorksheet(wb, sheet="Sheet1")
colnames(per.cap) <- c("yr", "tons", "pop")
per.cap.ts <- as.ts(per.cap)

per.cap.imp <- amelia (per.cap.ts, m = 5, ts = "yr", cs = "pop", polytime = 1)

summary (per.cap.imp)

plot (per.cap.imp)

results <- per.cap.imp$imputations

imputed.data <- as.data.frame (do.call('cbind',results))
imputed.data <- imputed.data [,c(2,5,8,11,14)]
imputed.data <- as.data.table (rowMeans(imputed.data))
write.csv (imputed.data, file = "imputed.waste.csv")
