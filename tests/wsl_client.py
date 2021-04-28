import requests
import time

def post_to_server(payload):
    ip = 'http://3.142.120.56:8080/'
    r = requests.post(ip, json=payload)
    print(r.json())
    return

while True:
    payload = {'pinary':'1000'}
    post_to_server(payload)
    time.sleep(1)

