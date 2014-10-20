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

df.gss<-subset(df.gss,!is.na(confinan) | !is.na(joblose),select=fields)
gss08<-subset(df.gss,year >= 2008,select=fields)

#Take a look
missmap(df.gss)



#Divide into to datasets; Two years beofre 2007 and two years after 2007
df.gss06<-df.gss[df.gss$year %in% c(2004,2006),]
df.gss08<-df.gss[df.gss$year >= 2008,]

#No joblose = Leaving Labor Force in 2004-2012 so get rid of it.
df.gss06$joblose<-factor(df.gss06$joblose)
df.gss08$joblose<-factor(df.gss08$joblose)

dev.off()
df.gss06<-df.gss[df.gss$year %in% c(2004,2006),]
df.gss08<-df.gss[df.gss$year > 2008,]
#No joblose = Leaving Labor Force in 2004-2012 so get rid of it.
df.gss06$joblose<-factor(df.gss06$joblose)
df.gss08$joblose<-factor(df.gss08$joblose)

#par(mfrow=c(1,1),mar=c(.01,5,5,.01),font.axis=8,mai=c(.01,1,1,.01))
par(mfrow=c(1,1),font.axis=9,font.lab=1.0,mai=c(.01,1,0.50,.01),omi=c(0.01,0.01,0.01,0.01))
col=c(3,4,5)
ylab<-"Confidence in U.S. Financial Institutions\n(gss$confinan)"
sub<-"Feelings of Job Loss Likelihood"
#plot(df.gss06$confinan~df.gss06$joblose,col=col,ylab=ylab);plot(df.gss08$confinan~df.gss08$joblose,col=col,srt=45)
main06="2004 - 2006"
main08="2010 - 2012"
cex.axis<-.80
las<-5
adj=1
mtext<-"Feelings of Job Loss Likelihood (gss$joblose)"
#mosaicplot(joblose~confinan,data=df.gss06,las=las,cex.axis=cex.axis,col=col,main=main06,ylab=ylab,xlab="")
#mtext(mtext)
mosaicplot(joblose~confinan,data=df.gss08,las=las,col=col,main=main08,cex.axis=cex.axis,ylab=ylab,xlab="")
mtext(mtext)
#mean(as.integer(df.gss06$confinan));mean(as.integer(df.gss08$confinan))




#na.gss.3 looks like the way to go.

#INFERENCE Section

agegroups<-c("Young","Middle","Older","Old")

gss$agefactor<-cut(gss$age,breaks=4,labels=agegroups)



chisq.test(df.gss08$confinan,df.gss08$joblose)
pchisq(12.8098,df=6,lower.tail=F)
