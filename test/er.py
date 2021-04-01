import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(20, GPIO.IN)
GPIO.setup(21, GPIO.OUT)

while True:
    if GPIO.input(20):
        GPIO.output(21, False)
        print("is on")
        time.sleep(1)
    else:
        print("is off")
        GPIO.output(21, True)
        time.sleep(1)

#        while True:
#            GPIO.output(21, True)
#            if GPIO.input(20):
#                break

def is_on():
    return GPIO.input(20)
