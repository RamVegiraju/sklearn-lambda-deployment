import requests
import json

url = "Enter function URL"

data = '{"data": [[5,5,3,2], [2,4,3,5]]}'
resp = requests.post(url, json = data)
print(resp.text)
