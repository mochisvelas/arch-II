# siempre leer interrupciones
# cuando se lee empezar a contar el tiempo de la interrup y decidir el size
# iniciar la secuencia de lavado
# CICLO:
# Detectar cualquier tipo de interrupcion
# Si se detecta interrupcion empezar conteo
# Determinar size en base al tiempo de interrupcion
# Imprimir size y hora de inicio
# Iniciar secuencia de lavado e imprimir cada paso
## 1. Primer lavado de agua 
## 2. Station de shampoo
## 3. Station de rodillos
## 4. Station de escobas
## 5. Segundo lavado de agua
## 6. Segunda station de rodillos
# Imprimir detalles de finaliza e ingresar registro a db:
## Fecha, hora, tiempo de cada section, costo total (x3 grande, x2 mediano, x1 peque) Q2/sec)
# Volver a iniciar ciclo

import RPi.GPIO as GPIO
import time
import mysql.connector
from datetime import datetime

#db = mysql.connector.connect(
#        host = "192.168.202.137",
#        user = "labpi",
#        passwd = "mochis",
#        database = "lab7")

#mycursor = db.cursor()

#mycursor.execute("describe er_table")
#mycursor.execute("select * from er_table")

#for i in mycursor:
#    print(i)

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

GPIO.setup(0, GPIO.OUT) # 1era agua
GPIO.setup(1, GPIO.OUT) # shampoo
GPIO.setup(7, GPIO.OUT) # 1era rodillos
GPIO.setup(8, GPIO.OUT) # escobas
GPIO.setup(4, GPIO.OUT) # 2da agua
GPIO.setup(5, GPIO.OUT) # 2da rodillos
GPIO.setup(6, GPIO.OUT) 
GPIO.setup(20, GPIO.IN) # sensor
GPIO.setup(21, GPIO.OUT)

while True:
    if GPIO.input(20):
        print("Bienvenido al car wash, pase adelante")
        while GPIO.input(20):
            continue
        #time.sleep(1)
    else:
        car_start = time.time()
        time_start = datetime.now().time()
        while not GPIO.input(20):
            continue
        car_end = time.time()
        car_size = car_end - car_start

        if car_size < 3:
            print("Ha ingresado un carro small a las:", str(time_start))
        elif car_size < 5:
            print("Ha ingresado un carro mediano a las:", str(time_start))
        else:
            print("Ha ingresado un carro grande a las:", str(time_start))

        # INICIO DE CICLO
        print("Iniciando secuencia de lavado...")
        time.sleep(2)

        # 1era LAVADO
        print("El vehiculo se encuentra en la primera seccion de lavado...")
        GPIO.output(0, True)
        time.sleep(3)
        GPIO.output(0, False)

        # SHAMPOO
        print("El vehiculo se encuentra en la seccion de shampoo...")
        GPIO.output(1, True)
        time.sleep(3)
        GPIO.output(1, False)

        # 1era RODILLOS
        print("El vehiculo se encuentra en la primer seccion de rodillos...")
        GPIO.output(7, True)
        time.sleep(3)
        GPIO.output(7, False)

        # ESCOBAS
        print("El vehiculo se encuentra en la seccion de escobas...")
        GPIO.output(8, True)
        time.sleep(3)
        GPIO.output(8, False)

        # 2da LAVADO
        print("El vehiculo se encuentra en la segunda seccion de lavado...")
        GPIO.output(4, True)
        time.sleep(3)
        GPIO.output(4, False)

        # 2da RODILLOS
        print("El vehiculo se encuentra en la segunda seccion de rodillos...")
        GPIO.output(5, True)
        time.sleep(3)
        GPIO.output(5, False)

        print("El lavado del vehiculo ha finalizado, esperamos vuelva pronto!")
        time.sleep(2)

        #print("size of car is",int(car_size))
        #print("el carro ha entrado a las", str(time_start))

        #mycursor.execute("insert into er_table values(default, default, 'interrupcion')")
        #db.commit()
        #print("Se ha detectado una interrupcion de sensor a las "+ str(datetime.now().time()))
        #time.sleep(1)

#mycursor.execute("insert into er_table values()")
#db.commit()

#mycursor.execute("select * from er_table")

#mycursor.execute("describe er_table")

#for i in mycursor:
#    print(i)
