install.packages("XLConnect")
installed.packages("data.table") #check
installed.packages("dplyr") #check
install.packages("readxl")
install.packages("xlsx")
library (data.table)
library (dplyr)
library (readxl)
library(xlsx)

#ways of importing excel and csv files
df1 <- read.csv(file="/Users/itsiryap/Desktop/mini_file.csv",head=TRUE,sep=",")
head(df1)
df2 <- read_excel("/Users/itsiryap/Desktop/Book1.xlsx", sheet=1)
head(df2)
df3<-read_xlsx("/Users/itsiryap/Desktop/Book1.xlsx", sheet=1)
head(df3)


#upload file
data<-read_excel("/Users/itsiryap/Desktop/work/WESyS/q4matstudyresult.xlsx", sheet=1)
head(data)

#separation of run from the variable name
#install.packages("reshape2")
library(reshape2) #function colsplit
# install.packages("stringr")
library(stringr) #function str_replace_all
#example
x1 <- c("`Run 2: Global Outputs.global total energy prod by config[NoWTE]`")
x1<-str_replace_all(x1, "`", "")
print(x1)
version1<-str_replace_all(x1, "Run [0-9]+: ", "")
print(version1)
version2<-colsplit(x1, ": ",c("","")) #по сути разделяет название на Run2 и название переменной
print(version2[1,1])


df1<-str_replace_all(df1, "`", "")
print(df1)
df1<-colsplit(df1, ": ",c("","")) #по сути разделяет название на Run2 и название переменной
# print(version2[1,1])

?melt

library(reshape2)

# example data frame
x = data.frame(
  id   = c(1, 1, 2, 2),
  blue = c(1, 0, 1, 0),
  red  = c(0, 1, 0, 1)
)
# collapse the data frame
# melt(data = x, id.vars = "id", measure.vars = c("blue", "red"))
# 
# ?gsub
#transposed data

my_file<-read.csv(file="/Users/itsiryap/Desktop/newmini.csv",head=TRUE,sep=",")
class(my_file)
head(my_file)
length(my_file[,2])

x<-my_file[,2]
y<-x[1]
print(y)
y<-strsplit(y,":")
x[1]<-str_remove_all(x[1],":")
# x<-str_replace_all(x, "7 Levels: ", "")
y<-x[3]
y<-colsplit(y, ":",c("",""))
for (i in 1:length(x)){
  
}
  

for (i in 1:length(my_file[,1])){#just to check what i chose
  print(my_file[i,1])
}


for (i in 1:5){
  print(i)
}
x<-colsplit(x, ": ",c("",""))
melt(data=my_file, id.vars = )

