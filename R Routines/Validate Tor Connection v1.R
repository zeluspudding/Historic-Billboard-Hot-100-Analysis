library(RCurl)
options(RCurlOptions = list(proxy = "socks5://127.0.0.1:9150"))
my.handle <- getCurlHandle()
#html <- getURL(url='http://www.ipchicken.com', curl=my.handle)

while(TRUE)
{
    html <- getURL(url='http://www.ipchicken.com', curl=my.handle) #this line must be in the loop
    doc = htmlTreeParse(html,useInternalNodes=T)
    html.parse<-xpathApply(doc, "//p", xmlValue)
    ip<-substr(html.parse[2], 6, 25)
    print(ip)
    Sys.sleep(5)
}