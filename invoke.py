import requests
import json

url = "https://yzxq6wjbydmz6wcfrzoyalpnke0eixed.lambda-url.us-east-1.on.aws/"

data = '{"data": [[5,5,3,2], [2,4,3,5]]}'
resp = requests.post(url, json = data)
print(resp.text)