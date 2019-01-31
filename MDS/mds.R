library(cluster)
data=read.csv("/home/jhome/Documents/MS/COPD_Cluster_Analysis/MDS/new copd data exclude outcome.csv")
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

plot(2:15,val,xlab="dimensions",ylab="stress")
lines(2:15,val)

i=sammon(dis,k=8) #6 or 8 to figure out

#Gower dissimilarity is not a metric so cannot use classical metric MDS


#How to choose the elbow.
#Cattell suggests to find the place where the 
#smooth decrease of stress values (eigenvalues in factor analysis)
#appears to level off to the right of the plot. To the right of this point
#,you find, presumably, only "factorial scree" - "scree" is the geological 
#term referring to the debris which collects on the lower part of a rocky slope.



#=======================Clustering==================
d_c=i$points
#=======Using hclust======
p=hclust(dist(d_c),method = "ward.D2")
plot(p)
b=cutree(p,k=5)
write.csv(b,"clusters.csv")
#=================Calculating the derivative===============
x=2:15

for(i in 1:14){
  print(x[i])
  s=(val[i+1]-val[i])/(x[i+1]-x[i])
  print(s)
}

#We can see that point 8 has the lowest slope value =-0.001164825. So we choose k=8
