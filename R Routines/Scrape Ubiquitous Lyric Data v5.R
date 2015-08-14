library(RCurl)
library(XML)
master<-read.csv("Master Billboard4 ONLY ERRORS Corrected v2.csv", stringsAsFactors=FALSE)
#master<-read.csv("Master Billboard3.csv", stringsAsFactors=FALSE)
master<-data.frame(master,"HitTarget"=NA)
newCircuits<-matrix(NA,dim(master)[1])

options(RCurlOptions = list(proxy = "socks5://127.0.0.1:9150"))
my.handle <- getCurlHandle()

for(song in 1:dim(master)[1]) {
    #Monitor IP Address
    html <- getURL(url='http://www.ipchicken.com', curl=my.handle) #this line must be in the loop
    doc = htmlTreeParse(html,useInternalNodes=T)
    html.parse<-xpathApply(doc, "//p", xmlValue)
    ip<-substr(html.parse[2], 6, 25)
    print(ip)
    newCircuits[song]<-ip
    
    #Scrape Lyrics
    if(master$Duplicate[song]==FALSE){#If unique, try URL.
        html <- getURL(url=master$Target[song], curl=my.handle, .opts = list(ssl.verifypeer = FALSE,followlocation=TRUE))
        targetMissed<-grepl("Ops! We couldn&#x27;t find that page",html)
        if(!targetMissed){ #If URL hit, parse and write lyric data to file. Then sleep for 5 seconds.
            interimParse = htmlTreeParse(html,useInternalNodes=T)
            parsedTarget<-xpathApply(interimParse, "//span", xmlValue)
            lyricIndex<-which.max(sapply(parsedTarget, nchar))
            #Proceed to next pass if there is a parsing error
            print(song)
            parseErrorFlag = try(parsedTarget[[lyricIndex]])
            
            if (class (parseErrorFlag) == "try-error") {
                #parseErrorFlag
                print("Parser Error")
            } else {
                lyric<-parsedTarget[[lyricIndex]]
                fileName<-paste0("Lyrics/",master$Year[song]," ",master$Rank[song],".txt")
                write(lyric,file = fileName)
                master$HitTarget[song]<-TRUE
            }
            Sys.sleep(5)
        } else master$HitTarget[song]<-FALSE #If URL missed, throw flag.
    } else{#If song is duplicate, make dummy file indicating so
        fileName<-paste0("Lyrics/",master$Year[song]," ",master$Rank[song],".txt")
        fileContent<-paste0("DUPLICATE, ",master$Title[song],", ",master$Artist[song],".txt")
        write(fileContent,file = fileName) 
    }
    print(dim(master)[1]-song) #Progress Bar    
}
print("DONE")
write.csv(master,file = "Master Billboard4.csv", row.names=FALSE)
write.csv(master$HitTarget,file = "Master Billboard4 ERRORS.csv", row.names=FALSE)
write.csv(newCircuits,file = "newCircuit Log.csv", row.names=FALSE)