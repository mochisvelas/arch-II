import RPi.GPIO as GPIO
from datetime import datetime
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(0, GPIO.IN) # PIC INPUT 1
GPIO.setup(1, GPIO.IN) # PIC INPUT 2
GPIO.setup(7, GPIO.IN) # PIC INPUT 3
GPIO.setup(8, GPIO.IN) # PIC INPUT 4
# GPIO.setup(4, GPIO.OUT) # DISPLAY 1:E
# GPIO.setup(5, GPIO.OUT) # DISPLAY 2:D
# GPIO.setup(6, GPIO.OUT) # DISPLAY 4:C
# GPIO.setup(9, GPIO.OUT) # DISPLAY 6:B
# GPIO.setup(10, GPIO.OUT) # DISPLAY 7:A
# GPIO.setup(11, GPIO.OUT) # DISPLAY 9:F
# GPIO.setup(12, GPIO.OUT) # DISPLAY 10:G

# GPIO.setup(20, GPIO.IN)
# GPIO.setup(21, GPIO.OUT)

def get_binary():
    bi_0 = 0
    bi_1 = 0
    bi_2 = 0
    bi_3 = 0

    # ADC 0
    if GPIO.input(21):
        bi_0 = 1

    # ADC 1
    if GPIO.input(20):
        bi_1 = 1

    # ADC 2
    if GPIO.input(16):
        bi_2 = 1

    # ADC 3
    if GPIO.input(12):
        bi_3 = 1

    pinary = str(bi_0) + str(bi_1) + str(bi_2) + str(bi_3)

    return pinary

def numcheck():

    pinary = get_binary()
    picimal = int(pinary, 2)
    
    return picimal


while True:
    aux = numcheck()
    print(aux)
    while True:
        actual = numcheck()
        if actual != aux:
            break

GPIO.cleanup()
