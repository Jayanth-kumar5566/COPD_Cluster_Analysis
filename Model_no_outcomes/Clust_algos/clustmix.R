library(clustMixType)
data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/new copd data exclude outcome.csv")
#3 to 4 clusters

#data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_with_outcomes/new copd include all data.csv")


rownames(data)=data$id
data=data[-1]

a <- lambdaest(data)
res <- kproto(data, k= 2, lambda = a)
clprofiles(res, data)

wss <- sapply(1:10, 
              function(k){kproto(data, k,lamda=a)$tot.withinss})
plot(1:10, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")
