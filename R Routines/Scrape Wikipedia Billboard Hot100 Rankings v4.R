#Version 4 creates double quoted csv
library(XML)
library(stringr)
library(plyr)

#First Official Annual Rank Source
#http://en.wikipedia.org/wiki/Billboard_year-end_top_100_singles_of_1958
#Remaining Official Annual Rank Sources
#http://en.wikipedia.org/wiki/Billboard_Year-End_Hot_100_singles_of_1959

year<-1958
theurl <- "http://en.wikipedia.org/wiki/Billboard_year-end_top_100_singles_of_1958"
tables <- readHTMLTable(theurl)
Hot100<-data.frame(year,tables[[1]] [1:3])
colnames(Hot100) <- c("Year","Rank","Title","Artist")
del <- colwise(function(Hot100) str_replace_all(Hot100, '\"', ""))
Hot100<-del(Hot100)
write.csv(Hot100, file = "Billboard Hot100 1958.csv", row.names=FALSE) 

baseurl<-"http://en.wikipedia.org/wiki/Billboard_Year-End_Hot_100_singles_of_"
for (year in 1959:2014 ) {
#Wikipedia markups such as "This article has multiple issues" will break this loop
    theurl <- paste0("http://en.wikipedia.org/wiki/Billboard_Year-End_Hot_100_singles_of_",year)
    tables <- readHTMLTable(theurl)
    fileName <- paste0("Billboard Hot100 ", year, ".csv")
    Hot100<-data.frame(year,tables[[1]] [1:3])
    colnames(Hot100) <- c("Year","Rank","Title","Artist")
    del <- colwise(function(Hot100) str_replace_all(Hot100, '\"', ""))
    Hot100<-del(Hot100)
    write.csv(Hot100, file = fileName, row.names=FALSE) 
}


#Use this for any years throwing errors on wiki
year<-2007
theurl <- paste0("http://en.wikipedia.org/wiki/Billboard_Year-End_Hot_100_singles_of_",year)
tables <- readHTMLTable(theurl)
fileName <- paste0("aaa Test", year, ".csv")
Hot100<-data.frame(year,tables[[1]] [1:3])
colnames(Hot100) <- c("Year","Rank","Title","Artist")
del <- colwise(function(Hot100) str_replace_all(Hot100, '\"', ""))
Hot100<-del(Hot100)
write.csv(Hot100, file = fileName, row.names=FALSE) 