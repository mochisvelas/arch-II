import requests

def post_to_server(payload):
    ip = 'http://18.218.129.43:8080/'
    r = requests.post(ip, json=payload)
    print(r)
    return

payload = {'20':'1'}
post_to_server(payload)

