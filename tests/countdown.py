import RPi.GPIO as GPIO
from datetime import datetime
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

cont = 11

er_cont = 0

GPIO.setup(0, GPIO.IN)
GPIO.setup(1, GPIO.IN) 

def countdown():
    global er_cont
    for i in range(cont):
        print('seconds:', i)
        if not GPIO.input(1):
            return
        time.sleep(1)
        if not GPIO.input(1):
            return

    #print('ending...')
    er_cont = 0
    return

while True:
    if not GPIO.input(1):
        er_cont = er_cont + 1

    while not GPIO.input(1):
        continue

    print('er_cont:', er_cont)

    countdown()
