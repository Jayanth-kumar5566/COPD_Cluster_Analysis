data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/maan_whitney/dataset.csv")
  
data=na.omit(data) #Add NA in the dataset for missing values(1 missing present)

rownames(data)=data$id
data=data[-1]

#with hcpc
#data=data[1:34] #to remove clustmix

#with clustmix
#data=data[c(1:33,35)]


#Splitting the data based clusters
X=split(data,data$Hcpc_3)
#X=split(data,data$clustmix)

pop1=X$'1'
pop2=X$'2'

nam=colnames(data)


#-----------Runnning the test for numerical------------
for (i in nam[1:7])
{p1=pop1[[i]]
 p2=pop2[[i]]

 t=wilcox.test(p1,p2,alternative = "two.sided",paired=FALSE)
 #print(c(i,t$p.value))
 if (t$p.value <= 0.05){print(i)}
}
#Plots
#hist(p1,xlim=c(10,100),col='red')
#hist(p2,xlim=c(10,100),add=T,col='blue')


#rununing the test for categorical----------------
for (i in nam[8:33])
  {p1=pop1[[i]]
   p2=pop2[[i]]
  x=rbind(summary(p1),summary(p2))
  #t=chisq.test(x,simulate.p.value = TRUE)
  t=fisher.test(x,simulate.p.value = TRUE)
  #print(c(i,t$p.value))
  if (t$p.value <= 0.05){print(i)}
  }


#------------Comparing with outcomes---------------------
for (i in nam[37])
{p1=pop1[[i]]
p2=pop2[[i]]

t=wilcox.test(p1,p2,alternative = "two.sided",paired=FALSE)
#print(c(i,t$p.value))
if (t$p.value <= 0.05){
  print(i)
  png(paste("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/maan_whitney/",i,".png",sep=''))
  boxplot(pop1[[i]],pop2[[i]],xlab=i)
  dev.off()
  }
}
#Plots
#hist(p1,xlim=c(10,100),col='red')
#hist(p2,xlim=c(10,100),add=T,col='blue')


for (i in nam[34:36])
{p1=pop1[[i]]
p2=pop2[[i]]
x=rbind(summary(p1),summary(p2))
#t=chisq.test(x,simulate.p.value = TRUE)
t=fisher.test(x,simulate.p.value = TRUE)
#print(c(i,t$p.value))
if (t$p.value <= 0.05){print(i)
  png(paste("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/maan_whitney/",i,".png",sep=''))
  par(mfrow=c(1,2))
  li=max(summary(pop1[[i]]),summary(pop2[[i]]))
  plot(pop1[[i]],xlab=i,ylim=c(1,li))
  plot(pop2[[i]],xlab=i,ylim=c(1,li))
  dev.off()}
}

#-----------------For 3 Clusters-----------------------
pop1=X$'1'
pop2=X$'2'
pop3=X$'3'

nam=colnames(data)

for (i in nam[37])
{p1=pop1[[i]]
p2=pop2[[i]]
p3=pop3[[i]]

t=kruskal.test(list(p1,p2,p3))
#print(c(i,t$p.value))
if (t$p.value <= 0.05){
  print(i)
  png(paste("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/maan_whitney/",i,".png",sep=''))
  boxplot(pop1[[i]],pop2[[i]],pop3[[i]],xlab=i)
  dev.off()
}
}
#Plots
#hist(p1,xlim=c(10,100),col='red')
#hist(p2,xlim=c(10,100),add=T,col='blue')


for (i in nam[34:36])
{p1=pop1[[i]]
p2=pop2[[i]]
p3=pop3[[i]]
x=rbind(summary(p1),summary(p2),summary(p3))
#t=chisq.test(x,simulate.p.value = TRUE)
t=fisher.test(x,simulate.p.value = TRUE)
#print(c(i,t$p.value))
if (t$p.value <= 0.05){print(i)
  png(paste("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/maan_whitney/",i,".png",sep=''))
  par(mfrow=c(1,3))
  li=max(x)
  plot(pop1[[i]],xlab=i,ylim=c(1,li))
  plot(pop2[[i]],xlab=i,ylim=c(1,li))
  plot(pop3[[i]],xlab=i,ylim=c(1,li))
  dev.off()}
}


