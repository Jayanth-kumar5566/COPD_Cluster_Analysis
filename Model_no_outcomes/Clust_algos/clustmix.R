library(clustMixType)
data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/new copd data exclude outcome.csv")
#3 to 4 clusters

#data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_with_outcomes/new copd include all data.csv")


rownames(data)=data$id
data=data[-1]

a <- lambdaest(data)
res <- kproto(data, k= 2, lambda = a)
clprofiles(res, data)

d=list()
for (i in 1:8){
wss <- sapply(1:15, 
              function(k){kproto(data, k,lamda=a)$tot.withinss})
d<-c(d,list(wss))}

d_mea=(d[[1]]+d[[2]]+d[[3]]+d[[4]]+d[[5]]+d[[6]]+d[[7]]+d[[8]])/8

d_var=c()
for (j in 1:15){
v=c()
for (i in 1:8){
  v=c(v,d[[i]][j])
}
d_var=c(d_var,var(v))}
plot(1:15, d_mea,ylim=range(c(d_mea-sqrt(d_var), d_mea+sqrt(d_var))),
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")
arrows(1:15, d_mea-sqrt(d_var), 1:15,d_mea+sqrt(d_var), length=0.05, angle=90, code=3)


#Two clusters(with mean over 8 iterations, with error bars see plot)