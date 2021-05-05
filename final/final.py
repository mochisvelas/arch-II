import requests
import RPi.GPIO as GPIO
import time


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
GPIO.setup(10, GPIO.OUT) # RELAY

## INPUT
GPIO.setup(25, GPIO.IN) # black
GPIO.setup(21, GPIO.IN) # pink
GPIO.setup(20, GPIO.IN) # grey
GPIO.setup(16, GPIO.IN) # red
GPIO.setup(12, GPIO.IN) # yellow

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


def get_binary():
    pinary = str(int(GPIO.input(21))) + str(int(GPIO.input(20))) + str(int(GPIO.input(16))) + str(int(GPIO.input(12)))

    return pinary

while True:
     if GPIO.input(25):
         try:
             payload = {'payload':get_binary()}
             r = post_to_server(payload)
             print(r)

             binary = r['display']
             display(binary)

         except:
             print('error gg')

         while GPIO.input(25):
             continue
     else:
         while not GPIO.input(25):
             continue

GPIO.cleanup()
