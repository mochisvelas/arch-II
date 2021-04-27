import requests

def post_to_server(payload):
    ip = 'http://18.223.102.148:8080/'
    r = requests.post(ip, json=payload)
    print(r.json())
    return

payload = {'20':'1'}
post_to_server(payload)

