import time
from read_write_serial import*

# System Initialization
system_init()
time.sleep(1)

while True:
    # Module1: Receive and Extracting data for displaying on the app
    if isMicrobitConnected:
        print("Receiving data...")
        time.sleep(10)
        readSerial()
    print(my_data)

    # Updating data
    time.sleep(1)
    data_file = open("data.json", 'w')
    json.dump(my_data, data_file)
    data_file = open("data.json", 'r')
    print("Data extracted")
    pass
