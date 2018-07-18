library(dunn.test)
data=read.csv("Documents/MS/COPD_Cluster_Analysis/MDS/Feature_selection/dataset.csv")
  
data=na.omit(data) #Add NA in the dataset for missing values(1 missing present)
rownames(data)=data$id
data=data[-1]

#Splitting the data based clusters
X=split(data,data$x)

pop1=X$'1'
pop2=X$'2'
pop3=X$`3`
pop4=X$`4`
pop5=X$'5'

nam=colnames(data)

sink("Documents/MS/COPD_Cluster_Analysis/MDS/Feature_selection/post_hoc.txt")
#--------------For 3 Clusters Outcome Comparision-----------------------

#Numerical
for (i in nam[37])
{p1=pop1[[i]]
p2=pop2[[i]]
p3=pop3[[i]]
p4=pop4[[i]]
p5=pop5[[i]]

t=kruskal.test(list(p1,p2,p3,p4,p5))
if (t$p.value <= 0.05){
  print(i)
  d=dunn.test(x=list(p1,p2,p3,p4,p5),method = 'bh',alpha=0.05,kw=FALSE,list = TRUE,table = FALSE,altp = TRUE)
  #png(paste("./Documents/MS/COPD_Cluster_Analysis/MDS/Feature_selection/",i,".png",sep=''))
  #boxplot(p1,p2,p3,p4,p5,xlab=i)
  #dev.off()
}
}

#Categorical
for (i in nam[34:36])
{p1=pop1[[i]]
p2=pop2[[i]]
p3=pop3[[i]]
p4=pop4[[i]]
p5=pop5[[i]]
x=rbind(summary(p1),summary(p2),summary(p3),summary(p4),summary(p5))
t=fisher.test(x,simulate.p.value = TRUE)
if (t$p.value <= 0.05){print(i)
  d=dunn.test(x=list(p1,p2,p3,p4,p5),method = 'bh',alpha=0.05,kw=FALSE,list = TRUE,table = FALSE,altp = TRUE)
  #png(paste("./Documents/MS/COPD_Cluster_Analysis/MDS/Feature_selection/",i,".png",sep=''))
   # par(mfrow=c(1,5))
   # li=max(x)
   # plot(p1,xlab=i,ylim=c(1,li))
   # plot(p2,xlab=i,ylim=c(1,li))
   # plot(p3,xlab=i,ylim=c(1,li))
   # plot(p4,xlab=i,ylim=c(1,li))
   # plot(p5,xlab=i,ylim=c(1,li))
  #dev.off()
}
}

#-----------------Cluster Characterization on 3-------------------

#Numerical plots
for (i in nam[1:7])
{p1=pop1[[i]]
p2=pop2[[i]]
p3=pop3[[i]]
p4=pop4[[i]]
p5=pop5[[i]]
t=kruskal.test(list(p1,p2,p3,p4,p5))
if (t$p.value <= 0.05){
  print(i)
  d=dunn.test(x=list(p1,p2,p3,p4,p5),method = 'bh',alpha=0.05,kw=FALSE,list = TRUE,table = FALSE,altp = TRUE)
  # png(paste("./Documents/MS/COPD_Cluster_Analysis/MDS/Feature_selection/",i,".png",sep=''))
  # boxplot(p1,p2,p3,p4,p5,xlab=i)
  # dev.off()
}
}

#Categorical Plots
for (i in nam[8:33])
{p1=pop1[[i]]
p2=pop2[[i]]
p3=pop3[[i]]
p4=pop4[[i]]
p5=pop5[[i]]
x=rbind(summary(p1),summary(p2),summary(p3),summary(p4),summary(p5))
t=fisher.test(x,simulate.p.value = TRUE)
if (t$p.value <= 0.05){print(i)
  d=dunn.test(x=list(p1,p2,p3,p4,p5),method = 'bh',alpha=0.05,kw=FALSE,list = TRUE,table = FALSE,altp = TRUE)
  # png(paste("./Documents/MS/COPD_Cluster_Analysis/MDS/Feature_selection/",i,".png",sep=''))
  # par(mfrow=c(1,5))
  # li=max(x)
  # plot(p1,xlab=i,ylim=c(1,li))
  # plot(p2,xlab=i,ylim=c(1,li))
  # plot(p3,xlab=i,ylim=c(1,li))
  # plot(p4,xlab=i,ylim=c(1,li))
  # plot(p5,xlab=i,ylim=c(1,li))
  # dev.off()
  }
}
sink()