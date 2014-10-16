#Start with a clean environment
rm(list=ls())

#Load some required packages
require(Amelia) # missmap needs this
require(Hmisc) # bystats

load(url("http://bit.ly/dasi_gss_data"))
download.file(url = "http://bit.ly/dasi_project_template", destfile = "dasi_project_template.Rmd")
source("http://bit.ly/dasi_inference")


#Subset the data
workers <- c("Working Fulltime", "Working Parttime", "Temp Not Working", "Unempl, Laid Off")
df.gss<-subset(gss,wrkstat %in% workers)
df.gss$wrkstat<-factor(df.gss$wrkstat)




table(gss$joblose,useNA="ifany")
table(gss$confinan,useNA="ifany")
fields<-c("caseid","year","age","sex","wrkstat","confinan","conbus","joblose","satfin","finrela") #jobsec too sparse. Looks like parsol wasn't asked until after 1993
df.gss<-df.gss[,fields]

bystats(as.integer(df.gss$confinan),as.integer(df.gss$joblose),as.integer(df.gss$jobsec),fun=function(x)c(Mean=mean(x),Median=median(x)))
na.gss<-subset(gss,!is.na(gss$confinan) & !is.na(gss$jobsec),select=fields)
na.gss.1<-subset(gss,!is.na(gss$confinan),select=fields)
na.gss.2<-subset(gss,!is.na(gss$joblose),select=fields)
na.gss.3<-subset(df.gss,!is.na(confinan) & !is.na(joblose),select=fields)
missmap(na.gss.1)
missmap(na.gss)
missmap(na.gss.3)

df.gss<-na.gss.3
df.gss06<-df.gss[df.gss$year %in% c(2004,2006),]
df.gss08<-df.gss[df.gss$year > 2007,]

plot(df.gss06$confinan~df.gss06$joblose);plot(df.gss08$confinan~df.gss08$joblose)



#na.gss.3 looks like the way to go.

#INFERENCE Section

agegroups<-c("Young","Middle","Older","Old")

gss$agefactor<-cut(gss$age,breaks=4,labels=agegroups)



