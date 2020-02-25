rm(list=ls())
library (data.table)

foo = structure(list(V2 = c("Saturday", "Saturday", "Saturday", "Sunday", 
                           "Sunday", "Sunday", "Sunday", "Sunday", "Sunday", "Saturday", 
                           "Saturday", "Saturday", "Saturday", "Sunday", "Sunday", "Saturday", 
                           "Saturday", "Sunday"), V3 = c("Evening", "Evening", "Evening", 
                                                         "Evening", "Evening", "Evening", "Evening", "Evening", "Evening", 
                                                         "Night", "Night", "Night", "Night", "Night", "Night", "Night", 
                                                         "Night", "Night"), V4 = c(16.2, 23.4, 29.4, 24.2, 24.2, 24.2, 
                                                                                   24.2, 25.4, 26.8, 25.6, 24.4, 24.4, 24.4, 25.2, 25.2, 25.2, 25.2, 
                                                                                   25.2), V5 = c(235.84, 235.29, 232.79, 233.89, 233.66, 233.38, 
                                                                                                 232.99, 233.21, 232.37, 231.55, 231.19, 231.63, 231.71, 231.23, 
                                                                                                 231.23, 231.23, 231.23, 231.23)), .Names = c("V2", "V3", "V4", 
                                                                                                                                              "V5"), row.names = c(NA, -18L), class = "data.frame")
foo <- as.data.table (foo)
nrow (subset (foo, V2 == "Saturday"))
nrow (subset (foo, V2 == "Sunday"))
nrow (subset (foo, V2 == "Saturday" & V3 == "Evening"))
nrow (subset (foo, V2 == "Saturday" & V3 == "Evening" | V3 == "Night"))

