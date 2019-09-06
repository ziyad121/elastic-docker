from elasticsearch import Elasticsearch 
import os 
import glob
import pandas as pd 


#data directory
os.chdir("C:/Users/meftahzd/Desktop/My_Stella project/data/sample")
files =glob.glob("*.*")


#creating dataframe for extracting text string 
def extract_txt_files(files):
    df = pd.DataFrame(columns = ("name","content"))
    counter = 1       
    for file in files:
        df.loc[counter] = file,open(file, "rt").read()
        counter = counter + 1
    return df 
df = extract_txt_files(files)


# Create Index 
es = Elasticsearch()
col_names = df.columns 
for row_number in range(df.shape[0]):
    body = dict([(name, str(df.iloc[row_number][name])) for name in col_names])
    #passing the body as index to elasticsearch
    es.index(index = 'elasticsearch_demo', doc_type = 'sample', body = body)