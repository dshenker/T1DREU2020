#setwd("/R codes model/Model 3/25.0")
#source('ode.smooth.R')

original.data<-read.csv("noise data 25%.csv",row.names=1)

original.data<-original.data[order(original.data$time),]
#original.data<-original.data[-1,]  # eliminita treatment column

original.data2<-original.data

original.data2[1,'time']<-1e-20 ##(t=0)
smooth.data<-original.data
smooth.data2<-original.data2
data.names<-colnames(original.data)
cols<-ncol(original.data)
rows<-nrow(original.data)

derivative.data<-array(0,dim=c((500-0)/0.01,cols))  #500/0.01
colnames(derivative.data)<-data.names
derivative.data<-data.frame(derivative.data)
derivative.data[,1]<-original.data[1,1]
#seq(0,500-0.01,0.01)
derivative.data$time<-seq(0,500-0.01,0.01)

approxi.data<-array(0,dim=c(((500-0)/0.01+1),cols))  #500/0.01
colnames(approxi.data)<-data.names
approxi.data<-data.frame(approxi.data)
approxi.data[,1]<-original.data[1,1]
approxi.data$time<-seq(0,500,0.01)

pdf("smoothing data.pdf")
par(mfrow=c(2,2))
for(i in 2:cols)
{
	smooth.data[,data.names[i]]<-predict(loess(original.data[,i]~original.data[,1]))
	smooth.data2[,data.names[i]]<-predict(loess(original.data2[,i]~log(original.data2[,1])))

	plot(original.data[,1],original.data[,i], ylab=data.names[i],xlab="Time [h]",log="x",main="")
	title(main="without log")
	lines(smooth.data[,1],smooth.data[,data.names[i]],col='blue')



	plot(original.data[,1],original.data2[,i], ylab=data.names[i],xlab="Time [h]",log="x",main="")
	title(main="with log")

	lines(smooth.data[,1],smooth.data2[,data.names[i]],col='green')

	#using log
	approxi.list<-approx(smooth.data[,1],smooth.data2[,data.names[i]],n=((500-0)/0.01+1)) 
	#without log
	
	approxi.data[,data.names[i]]<-approxi.list[[2]] 
	approxi.data[,'time']<-approxi.list[[1]] 
	lines(approxi.data[,1],approxi.data[,data.names[i]],col='green',lty=2)

	derivative.data[,data.names[i]]<-(approxi.data[2:nrow(approxi.data),data.names[i]]-approxi.data[1:(nrow(approxi.data)-1),data.names[i]])/0.001
}


write.csv(derivative.data[derivative.data$time%in%original.data$time,],file='derivation data 16 time course.smooth.csv',sep='/t')

dev.off()



