#install.packages("rvest")
library(rvest)

url <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"

file<-read_html(url)

fhtml<-html_nodes(file, "table")
table1 <- html_table(fhtml[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))


#limpiando caracteres
a <- gsub("MXN","",table$Sueldo)
a <- gsub("[^[:alnum:][:blank:]?]", "", a)
a <- gsub("mes", "", a)
a <- as.numeric(a)
table$Sueldo <- a

b <- gsub("Sueldos para Data Scientist en", "", table$Cargo)
table$Cargo <-b

#maximo
max.sueldo <- which.max(table$Sueldo)
table[max.sueldo,]

#Minimo
min.sueldo <- which.min(table$Sueldo)
table[min.sueldo,]