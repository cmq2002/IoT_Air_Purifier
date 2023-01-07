# IoT Air Purifier System - HCMUT Multidisciplinary Project
## General Information:
- Major Component: Sensor System and Mobile Apllication for Android.
- Purpose: 
  - The system has abilities to measure the temperature and humidity as well as detect the PM2.5 dust and harmful gases (such as Amonia, Sulfur, Benzene, Carbon      dioxide...) concentration.
  - The system also provide a friendly interface mobile application for displaying information, supervisor and control of the system.
- Devices:
  - Microbit central hub for external devices.
  - Air Quality Sensor MQ-135.
  - Temperature and Humidity Sensor DHT-11.
  - Optical Dust Sensor PM 2.5 GP2Y1010AU0F.
  - Power Adapter.
  - Mini Motor and propeller.
  - LCD 1602.
  - Extension circuit board.
  - Activated Carbon filer and PM2.5 filter. 
## About the Project Layout:
- IoT_Gateway folder contains the Python code to generate a Gateway between sensor system and AdaFruit server as well as simulating serial data using Null-modem Emulator and Hercules tools.
- Mobile_App folder uses to store the implementation of the app in Flutter.
## About the Project Behavior:
- Every 10 seconds, the system will take measurement of the air quality.
- Information will be stored on the AdaFruit Server for exploiting by the app.
- The mobile app:
  - allows users to turn on or turn off the system and also changing the speed of propeller when it comes to the purifier function.
  - prompt a warning message if any index exceed the safety boundary.
  - display information of the latest measurement.
  - provide a statistical chart in the past 10 minutes.

  
