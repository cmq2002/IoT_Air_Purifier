import sys
import json
from Adafruit_IO import MQTTClient
from microbit_connection import*

AIO_FEED_ID = ["temp", "humid", "pm2-dot-5", "harmful-gas", "propeller-speed", "status"]
AIO_USERNAME = "TungVan"
AIO_KEY = "aio_cjbM98lpaFyfD8Pm8T48Qg8bpqSg"

# For displaying information on the app
my_data = {"temp": "0", "humid": "0",
           "pm2-dot-5": "0", "harmful-gas": "0",
           "propeller_speed": "0", "status": "1", "write": "0"}
def connected(client):
    print("Connection Success ...")
    for feed in AIO_FEED_ID:
        client.subscribe(feed)

def subscribe(client, userdata, mid, granted_qos) :
    print("Subscribe Success ...")

def disconnected(client) :
    print("Stop Connection ...")
    sys.exit(1)

def message(client, feed_id, payload):
    print("Entering value : " + payload )
    if isMicrobitConnected:
        ser.write((str(payload) + "#").encode())

client = MQTTClient(AIO_USERNAME, AIO_KEY)
data_file = open("data.json", 'w')
json.dump(my_data, data_file)
data_file = open("data.json", 'r')

def system_init():
    client.on_connect = connected
    client.on_disconnect = disconnected
    client.on_message = message
    client.on_subscribe = subscribe
    client.connect()
    client.loop_background()
    print("Data initialized")

# def on_off():
#     my_data["status"] = 1 - my_data["status"]
#     my_data["write"] = 1
