import mysql.connector

db = mysql.connector.connect(
        host = "localhost",
        user = "mochis",
        passwd = "mochis",
        database = "sensordb")

mycursor = db.cursor()

mycursor.execute("insert into er_table values()")
db.commit()

mycursor.execute("select * from er_table")

#mycursor.execute("describe er_table")

for i in mycursor:
    print(i)
