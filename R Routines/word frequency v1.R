dest<-"Bags/"
setwd("~/School/Graduate School Admissions/Essay/Dynamic/DataWrangling")

master<-read.csv("Master Billboard7.csv")
setwd("~/School/Graduate School Admissions/Essay/Dynamic/DataWrangling/Lyrics")
fileNames<-as.matrix(paste0(master$Year," ", master$Rank,".txt"))
i<-1
tot_raw_len<-0

for(index in fileNames){
    if(master$Duplicate[i]==TRUE|master$Instrumental[i]==TRUE|master$I.Foreign[i]==TRUE){ #Skip
    } else {
        raw<-scan(index, character(0),quote = "")
        raw<-gsub("[^[:alnum:][:space:]']", "", raw)
        tot_raw_len<-length(raw)+tot_raw_len
    }
    i<-i+1
}

#tot_raw_len<-1752398

words<-vector(mode = "character", length = tot_raw_len)
tot_raw_len<-0
i<-1
for(index in fileNames){
    if(master$Duplicate[i]==TRUE|master$Instrumental[i]==TRUE|master$I.Foreign[i]==TRUE){ #Skip
    } else {
        raw<-scan(index, character(0),quote = "")
        raw<-gsub("[^[:alnum:][:space:]']", "", raw)
        words<-append(words, raw, after = tot_raw_len)
        tot_raw_len<-length(raw)+tot_raw_len
    }
    i<-i+1
}

break


head(sort(table(tolower(words)),decreasing=TRUE),20)