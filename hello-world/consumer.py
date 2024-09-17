from kafka import KafkaConsumer
from flask import Flask, render_template
from flask_socketio import SocketIO
import os
# Load environment variable
my_env_var = os.getenv('KAFKA_TOPIC', 'my-topic')
app = Flask(__name__)
socketio = SocketIO(app)

consumer = KafkaConsumer(
    my_env_var, 
    bootstrap_servers=[os.environ.get(
        'KAFKA_BOOTSTRAP_SERVERS',
        'my-cluster-kafka-bootstrap:9092'
    )], 
    auto_offset_reset='earliest', 
    enable_auto_commit=True, 
    group_id='my-group', 
    value_deserializer=lambda x: x.decode('utf-8')
)

@app.route('/')
def index():
    return render_template('index.html')

def kafka_consumer():
    # socketio.emit('env', {'data': os.environ.get('KAFKA_TOPIC','my-topic')})
    for message in consumer:
        print(f"Received: {message.value}")
        # print(f"Received: {message.value.decode('utf-8')}")
        socketio.emit('message', {'data': message.value})
        # socketio.emit('message', {'data': message.value.decode('utf-8')})
        
@socketio.event
def connect(sid):
    print('Client connected:', sid)
    socketio.emit('env', {'data': my_env_var}, to=sid)

if __name__ == '__main__':
    socketio.start_background_task(kafka_consumer)
    socketio.run(app, host='0.0.0.0', port=5000, allow_unsafe_werkzeug=True)