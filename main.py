from fastapi import FastAPI
import json
from gpt import GPTQuery
from sqlalchemy import create_engine

app = FastAPI()


f = open('./sample1.json')
data = json.load(f)
key = "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"
gptCall = GPTQuery(key)
db = create_engine('postgresql://postgres:1234567890@localhost:5432/slab')

@app.get('/{user_query}')
def index(user_query:str):
    statement = gptCall.make_sql_statement(user_query)
    result_set = db.execute(statement)
    print(statement)
    data = [row._asdict() for row in result_set]
    return data


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
