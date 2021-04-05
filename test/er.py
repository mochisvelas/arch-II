import RPi.GPIO as GPIO
import time
import mysql.connector

db = mysql.connector.connect(
        host = "localhost",
        user = "mochis",
        passwd = "mochis",
        database = "sensordb")

mycursor = db.cursor()

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(20, GPIO.IN)
GPIO.setup(21, GPIO.OUT)

while True:
    if GPIO.input(20):
        GPIO.output(21, False)
        print("is on")
        time.sleep(1)
        #mycursor.execute("insert into er_table values()")
        #db.commit()
    else:
        GPIO.output(21, True)
        print("is off")
        time.sleep(1)
