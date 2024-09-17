import time
import random
from kafka import KafkaProducer
import datetime
import os

topic_name = os.getenv('KAFKA_TOPIC', 'my-topic')
custom_header = os.getenv('CUSTOM_HEADER', 'default')
producer = KafkaProducer(
    bootstrap_servers=[os.environ.get(
        'KAFKA_BOOTSTRAP_SERVERS',
        'my-cluster-kafka-bootstrap:9092'
    )] 
)
kirby = [
   "(੭｡╹▿╹｡)੭",
   "<(˶ᵔᵕᵔ˶)>",
    "⊂(◉‿◉)つ",
    "¯\_(ツ)_/¯",
    "⊂(´・ω・｀⊂)",
    "⊂(´・◡・⊂ )∘˚˳°",
    "¯\_(ツ)_/¯",
    "(˶ᵔ ᵕ ᵔ˶)",
    "৻(  •̀ ᗜ •́  ৻)",
    "(╯'□')╯︵ ┻━┻",
]
my_env_var = topic_name.split('-')[0] 
while True:
    sleep_time = random.randint(1, 10)
    message = f"Hello world from {my_env_var if my_env_var != 'my' else 'default'} producer - "+ datetime.datetime.now().strftime("%H:%M:%S") + "\t" + kirby[sleep_time-1]
    producer.send(topic_name, message.encode('utf-8'))
    print(f"Sent: {message}")
    time.sleep(sleep_time)