import pandas

df=pandas.read_csv("loadings.csv")

col=df.columns.tolist()

col.pop(0)

c=[]

for i in col:
    c.append(df[df[str(i)]>=0.5]["Unnamed: 0"].tolist())
    
sel=sum(c,[])

sel=set(sel)

print sel
