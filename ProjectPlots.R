# Data Exploration and Cleanup
dev.off()
plot(df.gss$wrkstat)

#Check missing values in the data

par(mar=c(5,1,5,2))
par(mfrow=c(1,2),title="Fred")
main<-"Figure 1\nBEFORE\ngss data"
col<-c("yellow", "black")
missmap(df.gss,main=main,col=col,legend=FALSE,y.cex=0.001,x.cex=1.0)
na.gss.3<-subset(df.gss,!is.na(df.gss$confinan) & !is.na(df.gss$joblose),select=fields)
main<-"Figure 2\nAFTER\nFiltering out NAs"
col<-c("yellow", "black")
missmap(na.gss.3,main=main,col=col,legend=FALSE,y.cex=0.001,x.cex=1.0)


