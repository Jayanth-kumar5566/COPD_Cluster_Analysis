import pandas

df=pandas.read_csv("loadings.csv")

col=df.columns.tolist()

col.pop(0)

c=[]

for i in col:
    c.append(df[df["Dim.1"]>=0.4]["Unnamed: 0"].tolist())
    
sel=sum(c,[])

sel=set(sel)

print sel
