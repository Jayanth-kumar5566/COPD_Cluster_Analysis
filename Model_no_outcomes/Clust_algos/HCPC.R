library(factoextra)
library(FactoMineR)
data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/new copd data exclude outcome.csv")
rownames(data)=data$id
data=data[-1]
#FAMD
res.famd=FAMD(data,ncp=23)
res.famd$eig
res.hcpc <- HCPC(res.famd,nb.clust=-1,min=1)
#-----
d_new=res.hcpc$data.clust
summary(d_new$clust)
X=split(d_new,d_new$clust)
for (i in 1:5){
boxplot(X[[1]][[i]],X[[2]][[i]],X[[3]][[i]],X[[4]][[i]],X[[5]][[i]],X[[6]][[i]],X[[7]][[i]],X[[8]][[i]],X[[9]][[i]],X[[10]][[i]],xlab=i)
}
for (i in 6:31){
  par(mfrow=c(2,5))
  for (j in 1:10){
    plot(X[[j]][[i]],xlab=j,ylim=c(1,600))
    title(i)
  }
}


#Interpreting part to do