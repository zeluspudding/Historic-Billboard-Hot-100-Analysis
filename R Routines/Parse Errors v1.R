master<-read.csv("Master Billboard4.csv", stringsAsFactors=FALSE)
ErrorList<-data.frame(master$Duplicate,master$HitTarget)
uniqueErrorList<-master[!(master$Duplicate==TRUE),]

summary(ErrorList)
summary(uniqueErrorList$HitTarget)
round(as.numeric(summary(uniqueErrorList$HitTarget)[2:4])/dim(uniqueErrorList)[1]*100, digits = 1)

#Simplify list to only erroneous Title/Artist entries
masterErrorList<-uniqueErrorList[(uniqueErrorList$HitTarget==FALSE | uniqueErrorList$HitTarget=="NA"),]
write.csv(masterErrorList, file = "Master Billboard4 ONLY ERRORS.csv", row.names=FALSE) 