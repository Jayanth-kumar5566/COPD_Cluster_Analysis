data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_with_outcomes/data_preprocessed.csv")
rownames(data)=data$id
data=data[-1]

#Splitting data into categorical and numerical
num=data[1:11]
categ=data[12:53]

#numerical
Sample1=num[1:455,]
Sample2=num[456:911,]
  
#Man whitney u test
t1=wilcox.test(as.matrix(Sample1[2]),as.matrix(Sample2[2]))
hist(as.matrix(Sample1[2]),xlim=c(10,100),col='red')
hist(as.matrix(Sample2[2]),xlim=c(10,100),add=T,col='blue')

#categorical
cSample1=categ[1:455,]
cSample2=categ[456:911,]

#Chi squared test
x=as.matrix(cSample1[1])
y=as.matrix(cSample2[1])

n <- max(length(x), length(y))

length(x) <- n                      
length(y) <- n


