rm(list=ls())

install.packages ("e1071")
library ("e1071")
foo.data <- matrix (nrow = 22, ncol = 2)
foo.data [, 1] <- c (1.20962, 1.21036, 1.21006, 1.20873, 1.20658, 1.20676, 1.20576, 1.20555,
               1.20526, 1.20504, 1.20516, 1.20581, 1.20456, 1.20558, 1.20496, 1.20547,
               1.20382, 1.20312, 1.20259, 1.20306, 1.20137, 1.20089)

foo.data [, 2] <- seq (from = 1, to = 22, by = 1) #you don't have a time/data index

foo.svm <- svm (foo.data [,1] ~ foo.data [,2], type="nu-regression", kernel="radial" )

summary (foo.svm)

new.data <- c(23:30)
test <- predict(foo.svm, new.data)

