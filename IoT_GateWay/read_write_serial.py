from global_init import*

def processData(data):
    data = data.replace("!", "")
    data = data.replace("#", "")
    split_data = data.split(":")
    print(split_data)
    try:
        if split_data[1] == "TEMP":
            client.publish("temp", split_data[2])
            my_data["temp"] = split_data[2]
        elif split_data[1] == "HUMID":
            client.publish("humid", split_data[2])
            my_data["humid"] = split_data[2]
        elif split_data[1] == "PM2.5":
            client.publish("pm2-dot-5", split_data[2])
            my_data["pm2-dot-5"] = split_data[2]
        elif split_data[1] == "GAS":
            client.publish("harmful-gas", split_data[2])
            my_data["harmful-gas"] = split_data[2]
        elif split_data[1] == "STATUS":
            client.publish("status", split_data[2])
            my_data["status"] = split_data[2]
        elif split_data[1] == "SPEED":
            client.publish("propeller-speed", split_data[2])
            my_data["propeller-speed"] = split_data[2]
    except:
        pass

mess = ""
def readSerial():
    bytesToRead = ser.inWaiting()
    if (bytesToRead > 0):
        global mess
        mess = mess + ser.read(bytesToRead).decode("UTF-8")
    while ("#" in mess) and ("!" in mess):
        start = mess.find("!")
        end = mess.find("#")
        processData(mess[start:end + 1])
        if (end == len(mess)):
            mess = ""
        else:
            mess = mess[end + 1:]

def writeSerial(var, value):
    write_data = "!1:" + var + ":" + str(value) + "#"
    ser.write(write_data.encode())
