import requests

def post_to_server(payload):
    ip = 'http://18.116.32.184:8080/'
    r = requests.post(ip, json=payload)
    print(r.json())
    return

payload = {'er_time':'5'}
post_to_server(payload)

