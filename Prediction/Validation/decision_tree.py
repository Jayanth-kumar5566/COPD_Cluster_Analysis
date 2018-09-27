#=============Decision Tree using CART==================
from __future__ import division
from sklearn import tree
from sklearn.model_selection import cross_val_score
from sklearn.tree import DecisionTreeClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import pandas

df=pandas.read_csv("dataset.csv")
df1=pandas.read_csv("test_data.csv")
df.set_index("id",inplace=True)
df1.set_index("id",inplace=True)
df1.dropna(axis=0,how='any',inplace=True)
#==============Encoding Categorical variables==============
colnames=df.columns
le=LabelEncoder()

for i in range(7,36):
    df[colnames[i]]=le.fit_transform(df[colnames[i]])
    df1[colnames[i]]=le.fit_transform(df1[colnames[i]])
#===========Features and Labels split====================
X=df.drop('x',axis=1)
y=df['x']

#=========Test and Train Split==========================
X_train, X_test, y_train, y_test = train_test_split(X, y,test_size=0.3,random_state=0)
#clf = DecisionTreeClassifier(criterion='entropy',max_depth=4,min_samples_split=0.2,random_state=0,class_weight='balanced')

df2=df1.copy(deep=True)

for i in range(100):
    clf = DecisionTreeClassifier(criterion='entropy',max_depth=8,class_weight='balanced')
    clf=clf.fit(X_train,y_train)
    y_pred=clf.predict(X_test)
    y_score=clf.predict_proba(X_test)
    print "Accuracy of the predicition", accuracy_score(y_test,y_pred)

    #=======Validation prediction=======
    #Change dtype of df1 to float64, getting error
    val_y=clf.predict(df1)
    #To find function for probability scores
    val_prob=clf.predict_proba(df1)
    df2["x"+str(i)]=val_y

from collections import Counter
import operator
def max_rep_prob(x):
    z=Counter(x)
    y=max(z.iteritems(), key=operator.itemgetter(1))[1]
    return (y/len(x))

def max_rep(x):
    z=Counter(x)
    y=max(z.iteritems(), key=operator.itemgetter(1))[0]
    return y

max_val_prob=df2.iloc[:,36:].apply(max_rep_prob,axis=1)
max_val=df2.iloc[:,36:].apply(max_rep,axis=1)

df2['Probability of max value']=max_val_prob
df2['x_max value']=max_val
df2.to_csv("clusters.csv")
from collections import Counter
print Counter(val_y)

#or
#clf.score(X_test,y_test)
#=========Cross Validation on accuracy score===================
scores = cross_val_score(clf,X,y,cv=10)
print "Accuracy over Cross Validation 10 fold",(scores.mean(),scores.std())


'''
#================Feature Importance==================
f=clf.feature_importances_
f_imp=dict()
for i in range(37):
    f_imp[colnames[i]]=f[i]
#===========Tree Visuvalization==========================
import graphviz
dot_data = tree.export_graphviz(clf,out_file=None,feature_names=colnames[:-1],class_names=['C1','C2','C3','C4','C5'],filled=True, rounded=True,special_characters=True)
graph = graphviz.Source(dot_data)
graph.render("tree")
'''
#====================AUC Curve==============================
from sklearn.metrics import roc_curve, auc

def binary(y,cluster):
    y_n=[]
    for i in y:
        if i != cluster:
            y_n.append(0)
        else:
            y_n.append(1)
    return y_n

fpr = dict()
tpr = dict()
roc_auc = dict()
for i in range(1,6):
    fpr[i], tpr[i],th = roc_curve(binary(y_test,i), y_score[:, i-1])
    roc_auc[i] = auc(fpr[i], tpr[i])

import matplotlib.pyplot as plt

col={1:"red",2:"green",3:"darkorange",4:"black",5:"pink"}
plt.figure()
for i in range(1,6):
    plt.plot(fpr[i], tpr[i], color=col[i],label='ROC curve (area = %0.2f)' % roc_auc[i])
plt.plot([0, 1], [0, 1], color='navy', linestyle='--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic')
plt.legend(loc="lower right")
plt.show()
