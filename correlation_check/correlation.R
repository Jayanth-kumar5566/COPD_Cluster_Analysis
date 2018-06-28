data=read.csv("new copd data exclude outcome.csv")
rownames(data)=data$id
data=data[-1]
library(corrplot)

#===============For numerical========================
num=data[1:7]
M=cor(num,method="spearman")
corrplot(M)

cor.test(num$mmrc,num$cat,method="spearman",exact = FALSE)

cor.test(num$PostBDFEV1pred,num$PostBDFEV1FVC,method="spearman",exact = FALSE)

#Implying these variables are correlated....

#=================For categorical==================
#Applying Crammers V test
categ=data[8:33]

for(j in 1:26){
for (i in 1:26){
  t=table(categ[[j]],categ[[i]])
  tst=chisq.test(t,correct = F,simulate.p.value = TRUE)
  s=c(tst$statistic, tst$p.value)
  v=sqrt(tst$statistic[[1]]/sum(t))
  if (v>0.5){
    print(t)
    print(v)
  }
}
}

#Conclusion
#Categorical variables are not correlated