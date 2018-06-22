from __future__ import division
import pandas
import numpy
df=pandas.read_csv("clusters.csv")
df.set_index("Index",inplace=True)

print df.columns

#Difference between hcpc and kamila
total_pat=911
print "kamila and hcpc"
a=numpy.sum(df["kamila"]==df["hcpc"])

b=(a/total_pat)*100

if b<50:
    print 100-b
else:
    print b

print "kamila and clustmix"
a=numpy.sum(df["kamila"]==df["clustmix"])

b=(a/total_pat)*100

if b<50:
    print 100-b
else:
    print b

print "clustmix and hcpc"
a=numpy.sum(df["clustmix"]==df["hcpc"])

b=(a/total_pat)*100

if b<50:
    print 100-b
else:
    print b



    
