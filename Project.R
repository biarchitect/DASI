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

#Subset the fields

fields<-c("caseid","year","age","sex","wrkstat","confinan","conbus","joblose","satfin","finrela") #jobsec too sparse. Looks like parsol wasn't asked until after 1993
df.gss<-df.gss[,fields]

#Subset values in primary Fields ( remove NA rows)

df.gss<-subset(df.gss,!is.na(confinan) & !is.na(joblose),select=fields)

#Take a look
missmap(df.gss)

#Divide into to datasets; Two years beofre 2007 and two years after 2007
df.gss06<-df.gss[df.gss$year %in% c(2004,2006),]
df.gss08<-df.gss[df.gss$year > 2008,]

par(mfrow=c(1,2))
col=c(3,4,5)
ylab<-"Confidence in U.S. Financial Institution"
#plot(df.gss06$confinan~df.gss06$joblose,col=col,ylab=ylab);plot(df.gss08$confinan~df.gss08$joblose,col=col,srt=45)
main06="2004 - 2006"
main08="2010 - 2012"
mosaicplot(joblose~confinan,data=df.gss06,col=col,main=main06,ylab=ylab);mosaicplot(joblose~confinan,data=df.gss08,col=col,main=main08,ylab=NULL)


#mean(as.integer(df.gss06$confinan));mean(as.integer(df.gss08$confinan))




#na.gss.3 looks like the way to go.

#INFERENCE Section

agegroups<-c("Young","Middle","Older","Old")

gss$agefactor<-cut(gss$age,breaks=4,labels=agegroups)



