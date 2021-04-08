import RPi.GPIO as GPIO
from datetime import datetime
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(20, GPIO.IN)
GPIO.setup(21, GPIO.OUT)

while True:
    if GPIO.input(20):
        GPIO.output(21, False)
        #now = datetime.now().time()
        print("Se ha detectado la continuidad del sensor a las "+ str(datetime.now().time()))
        while GPIO.input(20):
            continue
        #print(now)
        #time.sleep(1)
    else:
        GPIO.output(21, True)
        #now = datetime.now().time()
        #print(now)
        print("Se ha detectado una interrupcion de sensor a las "+ str(datetime.now().time()))
        while not GPIO.input(20):
            continue
        #time.sleep(1)
