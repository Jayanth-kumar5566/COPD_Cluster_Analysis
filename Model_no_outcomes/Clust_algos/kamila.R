library(kamila)
data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_no_outcomes/new copd data exclude outcome.csv")

#data=read.csv("Documents/MS/COPD_Cluster_Analysis/Model_with_outcomes/new copd include all data.csv")


rownames(data)=data$id
data=data[-1]

#Remember to change this whenever you change the dataset


#Splitting data into categorical and numerical
num=data[1:7]
categ=data[8:33]

num=scale(num) #Scaling of the numeric variables
categ[] <- lapply(categ, factor)
#categDum <- dummyCodeFactorDf(categ)


kamRes <- kamila(as.data.frame(num),as.data.frame(categ),numClust=2:10,numInit=10,
                 calcNumClust = 'ps',numPredStrCvRun = 10, predStrThresh = 0.7)
summary(kamRes)
kamRes$nClust$psValues

plot(2:10, kamRes$nClust$psValues)
lines(2:10,kamRes$nClust$psValues)


#Suggest 2 clusters to 3
#The prediction strength is defined according to Tibshirani and Walther (2005), who recommend to choose as optimal number of cluster the largest 
#number of clusters that leads to a prediction strength above 0.8 or 0.9
