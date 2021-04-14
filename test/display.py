import RPi.GPIO as GPIO
from datetime import datetime
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(0, GPIO.OUT) # DISPLAY 1:E
GPIO.setup(1, GPIO.OUT) # DISPLAY 2:D
GPIO.setup(7, GPIO.OUT) # DISPLAY 4:C
GPIO.setup(8, GPIO.OUT) # DISPLAY 6:B
GPIO.setup(4, GPIO.OUT) # DISPLAY 7:A
GPIO.setup(5, GPIO.OUT) # DISPLAY 9:F
GPIO.setup(6, GPIO.OUT) # DISPLAY 10:G
GPIO.setup(20, GPIO.IN)
GPIO.setup(21, GPIO.OUT)

def zero():
    GPIO.output(0, True)
    GPIO.output(1, True)
    GPIO.output(7, True)
    GPIO.output(8, True)
    GPIO.output(4, True)
    GPIO.output(5, True)
    GPIO.output(6, False)
    return

def one():
    GPIO.output(0, False)
    GPIO.output(1, False)
    GPIO.output(7, True)
    GPIO.output(8, True)
    GPIO.output(4, False)
    GPIO.output(5, False)
    GPIO.output(6, False)
    return

def two():
    GPIO.output(0, True)
    GPIO.output(1, True)
    GPIO.output(7, False)
    GPIO.output(8, True)
    GPIO.output(4, True)
    GPIO.output(5, False)
    GPIO.output(6, True)
    return

def three():
    GPIO.output(0, False)
    GPIO.output(1, True)
    GPIO.output(7, True)
    GPIO.output(8, True)
    GPIO.output(4, True)
    GPIO.output(5, False)
    GPIO.output(6, True)
    return

def four():
    GPIO.output(0, False)
    GPIO.output(1, False)
    GPIO.output(7, True)
    GPIO.output(8, True)
    GPIO.output(4, False)
    GPIO.output(5, True)
    GPIO.output(6, True)
    return

def five():
    GPIO.output(0, False)
    GPIO.output(1, True)
    GPIO.output(7, True)
    GPIO.output(8, False)
    GPIO.output(4, True)
    GPIO.output(5, True)
    GPIO.output(6, True)
    return

def six():
    GPIO.output(0, True)
    GPIO.output(1, True)
    GPIO.output(7, True)
    GPIO.output(8, False)
    GPIO.output(4, True)
    GPIO.output(5, True)
    GPIO.output(6, True)
    return

def seven():
    GPIO.output(0, False)
    GPIO.output(1, False)
    GPIO.output(7, True)
    GPIO.output(8, True)
    GPIO.output(4, True)
    GPIO.output(5, False)
    GPIO.output(6, False)
    return

def eight():
    GPIO.output(0, True)
    GPIO.output(1, True)
    GPIO.output(7, True)
    GPIO.output(8, True)
    GPIO.output(4, True)
    GPIO.output(5, True)
    GPIO.output(6, True)
    return

def nine():
    GPIO.output(0, False)
    GPIO.output(1, False)
    GPIO.output(7, True)
    GPIO.output(8, True)
    GPIO.output(4, True)
    GPIO.output(5, True)
    GPIO.output(6, True)
    return

cont = 0
if cont == 0:
    zero()

time.sleep(1)
cont = cont + 1
if cont == 1:
    one()

time.sleep(1)
cont = cont + 1
if cont == 2:
    two()

time.sleep(1)
cont = cont + 1
if cont == 3:
    three()

time.sleep(1)
cont = cont + 1
if cont == 4:
    four()

time.sleep(1)
cont = cont + 1
if cont == 5:
    five()

time.sleep(1)
cont = cont + 1
if cont == 6:
    six()

time.sleep(1)
cont = cont + 1
if cont == 7:
    seven()

time.sleep(1)
cont = cont + 1
if cont == 8:
    eight()

time.sleep(1)
cont = cont + 1
if cont == 9:
    nine()

while True:
    if GPIO.input(20):
        GPIO.output(21, False)
        print("Se ha detectado la continuidad del sensor a las "+ str(datetime.now().time()))
        while GPIO.input(20):
            continue
        time.sleep(1)
    else:
        cont = cont  + 1
        GPIO.output(21, True)
        print("Se ha detectado una interrupcion de sensor a las", str(datetime.now().time()), cont)
        if cont == 0:
            zero()
        while not GPIO.input(20):
            continue
        time.sleep(1)

