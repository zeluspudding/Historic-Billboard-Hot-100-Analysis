initFile<-read.csv("Billboard Hot100 1958.csv", header = TRUE, sep = ",")
write.table(initFile, 
            "Master Billboard1.csv", 
            sep = ",", 
            dec = ".", 
            qmethod = "double",
            row.names=FALSE)

for (year in 1959:2014 ) {
fileName <- paste0("Billboard Hot100 ", year, ".csv")
    nextFile<-read.csv(fileName, header = TRUE, sep = ",")
    write.table(nextFile,
                "Master Billboard1.csv",
                sep = ",",
                dec = ".",
                qmethod = "double",
                row.names = FALSE,
                append = TRUE,
                col.names = FALSE)
}