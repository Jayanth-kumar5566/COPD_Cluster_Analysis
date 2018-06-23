data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_with_outcomes/man_whitney/dataset.csv")

data=na.omit(data) #Add NA in the dataset for missing values(1 missing present)

rownames(data)=data$id
data=data[-1]

sel_col=c()

#Splitting the data based clusters
X=split(data,data$clusters)
pop1=X$'1'
pop2=X$'2'

nam=colnames(data)

count=0
#-----------Runnning the test for numerical------------
for (i in nam[1:8])
{
 p1=pop1[[i]]
 p2=pop2[[i]]

 t=wilcox.test(p1,p2,alternative = "two.sided",paired=FALSE)
 #print(c(i,t$p.value))
 if (t$p.value <= 0.005){sel_col[count]=i;print(i);count=count+1}
}
#Plots
#hist(p1,xlim=c(10,100),col='red')
#hist(p2,xlim=c(10,100),add=T,col='blue')


#rununing the test for categorical----------------
for (i in nam[9:37])
  {p1=pop1[[i]]
   p2=pop2[[i]]
  x=rbind(summary(p1),summary(p2))
  #t=chisq.test(x,simulate.p.value = TRUE)
  t=fisher.test(x,simulate.p.value = TRUE)
  #print(c(i,t$p.value))
  if (t$p.value <= 0.005){sel_col[count]=i;print(i);count=count+1}
  }

for (i in sel_col[1:7]){
   png(paste("Documents/MS/COPD_Cluster_Analysis/Model_with_outcomes/man_whitney/",i,".png",sep='')) 
   boxplot(pop1[[i]],pop2[[i]],xlab=i)
   dev.off()
}


for (i in sel_col[8:19]){
  png(paste("Documents/MS/COPD_Cluster_Analysis/Model_with_outcomes/man_whitney/",i,".png",sep='')) 
  par(mfrow=c(1,2))
  li=max(summary(pop1[[i]]),summary(pop2[[i]]))
  plot(pop1[[i]],xlab=i,ylim=c(1,li))
  plot(pop2[[i]],xlab=i,ylim=c(1,li))
  dev.off()
}

