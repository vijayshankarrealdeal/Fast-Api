from fastapi import FastAPI
from typing import Optional
import json

app = FastAPI()


f = open('./sample1.json')
data = json.load(f)



@app.get('/')
def whole_Data():
    whole = []
    for d in data:
        whole.append(d)
        
    return whole
    


@app.get('/adt')
def company():
    return_data = []
    for d in data:
        # print(d)
        return_data.append([d['Supplier Name'],d['Average Delivery Time']])
    
    return return_data

@app.get('/companies')
def company():
    return_data = []
    for d in data:
        # print(d)
        return_data.append([d['Supplier Name'], d['Function']])
    
    return return_data

@app.get('/resources')
def company():
    return_data = []
    for d in data:
        # print(d)
        return_data.append([d['Supplier Name'], d['Resources']])
    
    return return_data
