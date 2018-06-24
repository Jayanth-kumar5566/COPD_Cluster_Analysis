library(factoextra)
library(FactoMineR)
data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/new copd data exclude outcome.csv")

#data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_with_outcomes/new copd include all data.csv")


rownames(data)=data$id
data=data[-1]

#FAMD
res.famd=FAMD(data,ncp=24)
res.famd$eig

res.hcpc <- HCPC(res.famd,nb.clust=3,min=1)


#HCPC outputs 10 clusters
