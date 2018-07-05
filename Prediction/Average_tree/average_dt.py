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


Accur=[]
#=========Test and Train Split==========================
for iter in range(1000):
#==================Averaging==========================
    D=[]
    for i in range(100):
        X_train, X_test, y_train, y_test = train_test_split(X, y,test_size=0.3)
        clf = DecisionTreeClassifier(criterion='entropy',max_depth=4,min_samples_split=0.2,class_weight='balanced')
        clf=clf.fit(X_train,y_train)

        #y_pred=clf.predict(X_test)

        #print "Accuracy of the predicition", accuracy_score(y_test,y_pred)

        #or

        #print "Accuracy of the predictor",clf.score(X_test,y_test)
        #===========Tree Visuvalization==========================
        import graphviz
        dot_data = tree.export_graphviz(clf,out_file=None,feature_names=colnames[:-1],class_names=['C1','C2','C3','C4','C5'],filled=True, rounded=True,special_characters=True)
        D.append(dot_data)
        #graph = graphviz.Source(dot_data)
        #graph.render("tree"+str(i))
    '''
    #==================Feature Importance========================
    f=clf.feature_importances_
    f_imp=dict()
    for i in range(37):
        f_imp[colnames[i]]=f[i]

    pdfunite tree*.pdf out.pdf
    '''
    from collections import Counter
    length=[]
    for i in D:
        x=[]
        for j in i.split(";"):
            if j[3:5]=="->":
                #print j[1:7]
                x.append(j[1:7])
        length.append(str(x))

    f=Counter(length)
    print f.values()
    Accur.append(max(f.values()))

#======================================
file=open("Accuracy.txt",'w')
for i in Accur:
    file.write(str(i)+'\n')

file.close()


#Not normal so, median=99.0 variance=1.3515
