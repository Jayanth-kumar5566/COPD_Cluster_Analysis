library(cluster)
data=read.csv("Documents/MS/COPD_Cluster_Analysis/MDS/new copd data exclude outcome.csv")
rownames(data)=data$id
data=data[-1]
dis=daisy(data,metric="gower")

library(MASS)
val=c()
for (j in 2:15){
#i=isoMDS(dis,k=j)
i=sammon(dis,k=j)
val=c(val,i$stress)
}

plot(2:15,val)
lines(2:15,val)


plot(i$points)

#Gower dissimilarity is not a metric so cannot use classical metric MDS
