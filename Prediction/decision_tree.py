#=============Decision Tree using CART==================
from sklearn import tree
from sklearn.model_selection import cross_val_score
from sklearn.tree import DecisionTreeClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import pandas

df=pandas.read_csv("dataset.csv")
df.set_index("id",inplace=True)


#==============Encoding Categorical variables==============
colnames=df.columns
le=LabelEncoder()

for i in range(7,36):
    df[colnames[i]]=le.fit_transform(df[colnames[i]])

#===========Features and Labels split====================
X=df.drop('x',axis=1)
y=df['x']

#=========Test and Train Split==========================
X_train, X_test, y_train, y_test = train_test_split(X, y,test_size=0.3,random_state=0)
clf = DecisionTreeClassifier(criterion='entropy',max_depth=4,min_samples_split=0.2,random_state=0,class_weight='balanced')
clf=clf.fit(X_train,y_train)

y_pred=clf.predict(X_test)

print "Accuracy of the predicition", accuracy_score(y_test,y_pred)

#or

#clf.score(X_test,y_test)
#=========Cross Validation on accuracy score===================
scores = cross_val_score(clf,X,y,cv=10)
print "Accuracy over Cross Validation 10 fold",(scores.mean(),scores.std())
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
