import requests
import time

def post_to_server(payload):
    ip = 'http://18.116.70.113:8080/'
    r = requests.post(ip, json=payload)
    print(r.json())
    return

while True:
    payload = {'pival':'not_waiting','wait':'0'}
    try:
        post_to_server(payload)
    except:
        print('error gg')

    time.sleep(1)

