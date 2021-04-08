import RPi.GPIO as GPIO
import time
import mysql.connector
from datetime import datetime

db = mysql.connector.connect(
        host = "192.168.202.137",
        user = "labpi",
        passwd = "mochis",
        database = "lab7")

mycursor = db.cursor()

#mycursor.execute("describe er_table")
#mycursor.execute("select * from er_table")

#for i in mycursor:
#    print(i)

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(20, GPIO.IN)
GPIO.setup(21, GPIO.OUT)

while True:
    if GPIO.input(20):
        GPIO.output(21, False)
        mycursor.execute("insert into er_table values(default, default, 'continuidad')")
        db.commit()
        print("Se ha detectado la continuidad del sensor a las "+ str(datetime.now().time()))
        while GPIO.input(20):
            continue
        #time.sleep(1)
    else:
        GPIO.output(21, True)
        mycursor.execute("insert into er_table values(default, default, 'interrupcion')")
        db.commit()
        print("Se ha detectado una interrupcion de sensor a las "+ str(datetime.now().time()))
        while not GPIO.input(20):
            continue
        #time.sleep(1)

#mycursor.execute("insert into er_table values()")
#db.commit()

#mycursor.execute("select * from er_table")

#mycursor.execute("describe er_table")

#for i in mycursor:
#    print(i)
