from fastapi import FastAPI
import json
from gpt import GPTQuery
from sqlalchemy import create_engine

app = FastAPI()


key = "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"
gptCall = GPTQuery(key)
db = create_engine('postgresql://postgres:1234567890@localhost:5432/slab')

@app.get('/query/{user_query}')
def index(user_query:str):
    if 'year' in user_query:
        user_query = user_query.replace('year','years')
    statement = gptCall.make_sql_statement(user_query)
    result_set = db.execute(statement)
    data = [row._asdict() for row in result_set]
    return data

@app.get('/app/top_rating')
def company():
    statement = 'SELECT * FROM stable where rating > 90'
    result_set = db.execute(statement)
    data = [row._asdict() for row in result_set]
    return data
    
