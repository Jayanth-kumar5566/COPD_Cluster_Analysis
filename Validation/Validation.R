library(cluster)
der_data=read.csv("/home/jhome/Documents/MS/COPD_Cluster_Analysis/MDS/new copd data exclude outcome.csv",row.names = 1)
val_data=read.csv("/home/jhome/Documents/MS/COPD_Cluster_Analysis/Validation/all_validation.csv",row.names = 1)
col_n=intersect(colnames(der_data),colnames(val_data))
der_data=der_data[,col_n]
val_data=val_data[,col_n]

#Derivation cohort no missing values, in validation cohort we have
#missing values in columns such as BMI, packyears, CAT score

#Derivation of the clusters
library(MASS)
dis=daisy(der_data,metric="gower")
i=sammon(dis,k=8) #6 or 8 to figure out
d_c=i$points
#=======Using hclust======
p=hclust(dist(d_c),method = "ward.D2")
plot(p)
b=cutree(p,k=5)

#plotting the clusters using NMDS
d_c_b=merge(d_c,as.data.frame(b),by="row.names",all=TRUE)
row.names(d_c_b)<-d_c_b$Row.names
d_c_b$Row.names<-NULL
library(ggplot2)
d_c_b$b<-factor(d_c_b$b)
ggplot(as.data.frame(d_c_b),aes(x=V1,y=V2,color=b))+geom_point()+scale_color_manual(breaks = c(1,2,3,4,5),values=c("red", "blue", "green", "black", "pink"))

#Can use tsne to visuvalize d_c

#--------------------Validation cohort--------------------
library(MASS)
dis=daisy(val_data,metric="gower")
#Patient No HP0011 and sgh_246 have same values, checking the data is ongoing
val=c()
for (j in 2:15){
  #i=isoMDS(dis,k=j)
  i=sammon(dis,k=j)
  val=c(val,i$stress)
}

plot(2:15,val,xlab="dimensions",ylab="stress")
lines(2:15,val)


i=sammon(dis,k=8) #8 or 11 to figure out [fixed on 8] can recheck
d_c=i$points



