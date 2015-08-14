setwd("~/School/Graduate School Admissions/Essay/Dynamic/DataWrangling")
master<-read.csv("Master Billboard6.csv")

setwd("~/School/Graduate School Admissions/Essay/Dynamic/DataWrangling/Lyrics")
fileNames<-as.matrix(paste0(master$Year," ", master$Rank,".txt"))
#master$LineCount<-"NA"
master$BadString<-"NA"

i<-1
for(index in fileNames){
    if (any(grep("Read more:",readLines(index),ignore.case=TRUE,value=TRUE)>0)) {
        master$BadString[i]<-TRUE
    }
    if (any(grep("Chorus",readLines(index),ignore.case=TRUE,value=TRUE)>0)) {
        master$BadString[i]<-TRUE
    }
    if (any(grep("intro:",readLines(index),ignore.case=TRUE,value=TRUE)>0)) {
        master$BadString[i]<-TRUE
    }
    if (any(grep("\\[",readLines(index),ignore.case=TRUE,value=TRUE)>0)) {
        master$BadString[i]<-TRUE
    }
    i<-i+1
}

#master$LineCount<-as.numeric(master$LineCount)
errors<-master[master$BadString==TRUE,]
write(fileNames[master$BadString==TRUE,],file="error_file.txt")

fileNames<-fileNames[which(master$LineCount<4)]
smallFiles<-master[which(master$BadString==FALSE),]
dim(master[master$Instrumental==TRUE,])