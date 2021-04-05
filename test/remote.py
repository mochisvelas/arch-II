import RPi.GPIO as GPIO
import time
import mysql.connector

db = mysql.connector.connect(
        host = "192.168.1.2",
        user = "predator",
        passwd = "mochis",
        database = "sensordb_remote")

mycursor = db.cursor()

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(20, GPIO.IN)
GPIO.setup(21, GPIO.OUT)

while True:
    if GPIO.input(20):
        GPIO.output(21, False)
        #print("off")
        #time.sleep(1)
    else:
        GPIO.output(21, True)
        #mycursor.execute("insert into er_table values()")
        #db.commit()
        print("on")
        while not GPIO.input(20):
            continue
        #time.sleep(1)

#mycursor.execute("insert into er_table values()")
#db.commit()

#mycursor.execute("select * from er_table")

#mycursor.execute("describe er_table")

#for i in mycursor:
#    print(i)
