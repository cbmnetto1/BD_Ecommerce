from dotenv import load_dotenv
import os
import mysql.connector

load_dotenv()

conn = mysql.connector.connect(
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASS"),
    database=os.getenv("DB_NAME")
)

cursor = conn.cursor()

with open("models.sql", "r", encoding="utf-8") as file:
    sql_script = file.read()

for statement in sql_script.strip().split(";"):
    if statement.strip():
        cursor.execute(statement + ";")

conn.commit()
cursor.close()
conn.close()

print("Database initialized successfully.")