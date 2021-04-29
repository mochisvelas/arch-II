import requests
import RPi.GPIO as GPIO


GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

## OUTPUT
GPIO.setup(0, GPIO.OUT) # DISPLAY A - orange
GPIO.setup(1, GPIO.OUT) # DISPLAY B - blue
GPIO.setup(7, GPIO.OUT) # DISPLAY C - brown
GPIO.setup(8, GPIO.OUT) # DISPLAY D - purple
GPIO.setup(4, GPIO.OUT) # DISPLAY E - white
GPIO.setup(5, GPIO.OUT) # DISPLAY F - black
GPIO.setup(6, GPIO.OUT) # DISPLAY G - yellow
GPIO.setup(9, GPIO.OUT) # LED - green

## INPUT
GPIO.setup(25, GPIO.IN) # MASTER - green
GPIO.setup(21, GPIO.IN) # SWITCH 1 - grey
GPIO.setup(20, GPIO.IN) # SWITCH 2 - pink
GPIO.setup(16, GPIO.IN) # SWITCH 3 - orange
GPIO.setup(12, GPIO.IN) # SWITCH 4 - yellow

def post_to_server(payload):
    ip = 'http://3.142.120.56:8080/'
    r = requests.post(ip, json=payload)
    r = r.json()
    return r

def display(binary):
    GPIO.output(0, binary[0] == '1')
    GPIO.output(1, binary[1] == '1')
    GPIO.output(7, binary[2] == '1')
    GPIO.output(8, binary[3] == '1')
    GPIO.output(4, binary[4] == '1')
    GPIO.output(5, binary[5] == '1')
    GPIO.output(6, binary[6] == '1')
    GPIO.output(9, binary[7] == '1')
    return

# def post_to_server(payload):
#     ip = 'http://3.142.120.56:8080/'
#     r = requests.post(ip, json=payload)
#     binary = r.json()['display']
#     GPIO.output(0, binary[0] == '1')
#     GPIO.output(1, binary[1] == '1')
#     GPIO.output(7, binary[2] == '1')
#     GPIO.output(8, binary[3] == '1')
#     GPIO.output(4, binary[4] == '1')
#     GPIO.output(5, binary[5] == '1')
#     GPIO.output(6, binary[6] == '1')
#     GPIO.output(9, binary[7] == '1')
#     return

def get_binary():
    bi_0 = 0
    bi_1 = 0
    bi_2 = 0
    bi_3 = 0

    # SWITCH 1
    if GPIO.input(21):
        bi_0 = 1

    # SWITCH 2
    if GPIO.input(20):
        bi_1 = 1

    # SWITCH 3
    if GPIO.input(16):
        bi_2 = 1

    # SWITCH 4
    if GPIO.input(12):
        bi_3 = 1

    pinary = str(bi_0) + str(bi_1) + str(bi_2) + str(bi_3)

    return pinary

while True:

    #payload = {'pinary':get_binary()}
    #r = post_to_server(payload)

#    if r['active'] == 'True':
#        binary = r['display']
#        display(binary)

     if GPIO.input(25):

         payload = {'pinary':get_binary()}
         r = post_to_server(payload)
         print(r)
         binary = r['display']
         display(binary)

         while GPIO.input(25):
             continue

     else:
         while not GPIO.input(25):
             continue

GPIO.cleanup()
