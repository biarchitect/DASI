rm(list=ls())

require(Amelia)
require(Hmisc)

load(url("http://bit.ly/dasi_gss_data"))
download.file(url = "http://bit.ly/dasi_project_template", destfile = "dasi_project_template.Rmd")
source("http://bit.ly/dasi_inference")


#Subset the data
working <- c("Working Fulltime", "Working Parttime", "Temp Not Working", "Unempl, Laid Off")
workers<-subset(gss,wrkstat %in% working)

table(gss$joblose,useNA="ifany")
table(gss$confinan,useNA="ifany")
fields<-c("caseid","year","age","sex","wrkstat","confinan","conbus","joblose","satfin","finrela") #jobsec too sparse. Looks like parsol wasn't asked until after 1993
df.gss<-gss[,fields]
missmap(df.gss)
bystats(as.integer(df.gss$confinan),as.integer(df.gss$joblose),as.integer(df.gss$jobsec),fun=function(x)c(Mean=mean(x),Median=median(x)))
na.gss<-subset(gss,!is.na(gss$confinan) & !is.na(gss$jobsec),select=fields)
na.gss.1<-subset(gss,!is.na(gss$confinan),select=fields)
na.gss.2<-subset(gss,!is.na(gss$joblose),select=fields)
na.gss.3<-subset(gss,!is.na(gss$confinan) & !is.na(gss$joblose),select=fields)
missmap(na.gss.1)
missmap(na.gss)
missmap(na.gss.3)

#na.gss.3 looks like the way to go.

agegroups<-c("Young","Middle","Older","Old")

gss$agefactor<-cut(gss$age,breaks=4,labels=agegroups)

