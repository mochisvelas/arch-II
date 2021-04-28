import requests

def post_to_server(payload):
    ip = 'http://3.142.120.56:8080/'
    r = requests.post(ip, json=payload)
    print(r.json())
    return

payload = {'pinary':'1111'}
post_to_server(payload)

