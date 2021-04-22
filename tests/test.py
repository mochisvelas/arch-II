import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(20, GPIO.IN)
GPIO.setup(21, GPIO.OUT)

while True:
    if GPIO.input(20):
        GPIO.output(21, False)
        print("off")
        time.sleep(1)
    else:
        GPIO.output(21, True)
        print("on")
        #while not GPIO.input(20):
        #    continue
        time.sleep(1)
