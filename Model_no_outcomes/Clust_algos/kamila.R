library(kamila)
data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/new copd data exclude outcome.csv")
rownames(data)=data$id
data=data[-1]
#Splitting data into categorical and numerical
num=data[1:5]
categ=data[6:31]

num=scale(num) #Scaling of the numeric variables
categ[] <- lapply(categ, factor)
#categDum <- dummyCodeFactorDf(categ)

#set.seed(6)

a=c()
for (i in 1:100){
set.seed(runif(1,0,.Machine$integer.max))
kamRes <- kamila(as.data.frame(num),as.data.frame(categ),numClust=2:10,numInit=10,
                 calcNumClust = 'ps',numPredStrCvRun = 10, predStrThresh = 0.7)
b=kamRes$nClust$psValues
a=rbind(a,b)
}

#--------------Mean and std------------------------
sink("results.txt")
for (i in 1:9){
  print(i)
  m=mean(a[,i])
  s=sqrt(var(a[,i]))
  print(m)
  print(s)
  #shapiro.test(a[,i])
}
sink()

write.csv(a,"values.csv")


#Averaged over 100 iterations

#2 0.6495593
#3 0.4603619
#4 0.4519158
#5 0.3664906
#6 0.3481052
#7 0.2878525

#Suggests only two clusters



#The prediction strength is defined according to Tibshirani and Walther (2005), who recommend to choose as optimal number of cluster the largest 
#number of clusters that leads to a prediction strength above 0.8 or 0.9
