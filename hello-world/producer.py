import time
import random
from kafka import KafkaProducer
import datetime
import os
producer = KafkaProducer(
    bootstrap_servers=[os.environ.get(
        'KAFKA_BOOTSTRAP_SERVERS',
        'my-cluster-kafka-bootstrap:9092'
    )] 
)

while True:
    message = "Hello world " + datetime.datetime.now().strftime("%H:%M:%S")
    producer.send(os.environ.get('KAFKA_TOPIC','my-topic'), message.encode('utf-8'))
    print(f"Sent: {message}")
    sleep_time = random.randint(1, 10)
    time.sleep(sleep_time)