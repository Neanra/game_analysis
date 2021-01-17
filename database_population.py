# -*- coding: utf-8 -*-
"""
Created on Fri Jan 16 12:48:31 2021

@author: Julia Issajeva
"""

import random
import uuid
import time
import mysql.connector

games = ["Tina's journey", "Happy Farm", "Secrets of the East", "Pirate Adventures"]
platforms = ["Android", "Facebook", "iOS"]
install_types = ["First Install", "Reinstall"]
time_range = ['2019-01-01 00:00:00', '2019-09-01 00:00:00']
number_of_records = 10000
max_number_of_payments = 30
database_connection_info = ["root", "swan0000", "127.0.0.1", "games_info"]


def get_date(start, end):
    format1 = "%Y-%m-%d %H:%M:%S"
    stime = time.mktime(time.strptime(start, format1))
    etime = time.mktime(time.strptime(end, format1))
    
    dif = etime - stime
    return time.strftime(format1, time.localtime(stime + dif * random.random()))

def get_id():
    return uuid.uuid4().hex

def format_record(record):
    s = "("
    for i in range(0, len(record)):
        if i !=0:
            s +=", "
        if type(record[i]) == str:
            s += "\"" + record[i] + "\""
        else:
            s += str(record[i])
    s += ")"
    return s

def populate_payments(cursor, install_instance):
    records_count = random.randint(0, max_number_of_payments)
    for i in range(0, records_count):
        record = install_instance[:3]
        record.append(get_date(install_instance[3], time_range[1]))
        record.append(random.randint(49,9999)/100)
        cursor.execute('INSERT INTO payments VALUES ' + format_record(record))

def populate_database(connector, records_count):
    cur = connector.cursor()
    for i in range (0, records_count):
        record = []
        record += random.sample(games,1)
        record += random.sample(platforms,1)
        record.append(get_id())
        record.append(get_date(time_range[0], time_range[1]))
        record.append(install_types[0])
        cur.execute('INSERT INTO installs VALUES' + format_record(record))
        populate_payments(cur, record)
        if random.random()<0.3:
            record1 = record.copy()
            record1[3] = get_date(record[3], time_range[1])
            record1[4] = install_types[1]
            cur.execute('INSERT INTO installs VALUES' + format_record(record1))
    connector.commit()
    cur.close()
    

        
        
conn = mysql.connector.connect(user = database_connection_info[0], 
                               password = database_connection_info[1], 
                               host = database_connection_info[2], 
                               database = database_connection_info[3])
populate_database(conn, number_of_records)
conn.close()

    