import openai


class GPTQuery:
    def __init__(self, key):
        openai.api_key = key
        self.key = key
    ###

    def giveMePromt(self, query_user: str):
        x = f"""### Postgres SQL tables, with their properties:
        #
        #stable(supplier_name,region,country,
		    department,price,rating,average_delivery_time,
			number_of_escalations,years,resources
		)
    #
    ###A query to list of {str(query_user)} SELECT""",
        return x
    ###

    def make_sql_statement(self, query_user: str):

        response = openai.Completion.create(
            engine="text-davinci-002",
            prompt=self.giveMePromt(query_user),
            temperature=0,
            max_tokens=500,
            top_p=1.0,
            frequency_penalty=0.0,
            presence_penalty=0.0,
            stop=["#", ";"]
        )
        text = response['choices'][0]['text']
        statement = "SELECT " + str(text) + ';'
        return statement
