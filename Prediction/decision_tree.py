from sklearn.model_selection import cross_val_score
from sklearn.tree import DecisionTreeClassifier
from sklearn.preprocessing import LabelEncoder
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

#=========Cross Validation on accuracy score===================
clf = DecisionTreeClassifier(random_state=0)
scores = cross_val_score(clf,X,y,cv=10)
print scores
