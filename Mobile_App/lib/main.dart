//region imports

import 'package:flutter/material.dart';
import 'Body/model/db4/Db4Model.dart';
import 'Body/screen/ChartBody/model/ChartBodyModel.dart';
import 'Body/screen/ControlBody/model/ControlBodyModel.dart';
import 'Body/screen/Main.dart';
import 'Body/screen/ProfileBody/model/ProfileBodyModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//endregion

/// This variable is used to get dynamic colors when theme mode is changed
Data data=Data();
Number number= Number();
Chart humidChart= Chart();
Chart harmfulChart= Chart();
Chart dustChart= Chart();
Chart tempChart= Chart();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications',// description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> showNotification() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  flutterLocalNotificationsPlugin.show(
      0,
      "Warning",
      "Harmful Gas or Dust over permission",
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              importance: Importance.high,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher')));
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await data.readJsondata();
  await humidChart.fetchData("humid");
  await harmfulChart.fetchData("harmful-gas");
  await tempChart.fetchData("temp");
  await dustChart.fetchData("pm2-dot-5");
  runApp(MyApp());

  //endregion
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Main(),

    );
  }
}
