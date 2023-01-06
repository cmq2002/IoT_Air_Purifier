import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../config.dart';

class Chart {
  String timeStart='';
  String timeEnd='';
  String timeLastData='';
  String timeLastDataString='';
  List<String> data=[];
  List<String> time=[];
  List<int> timeScale=[];
  Future<void> init() async{
    data=[];
    time=[];
    timeScale=[];
  }

  void fromJson(List<dynamic> json) {
    for(int i=0;i<json.length;i++){
      data.add(json[i]["value"].toString());
      time.add(json[i]["created_epoch"].toString());
    }
    for(int i=0;i<json.length;i++){
      timeScale.add(int.parse(time[i])-int.parse(time[time.length-1]));
    }
    //print(timeScale);
    print(data);
  }
  fetchData(String static) async{
    await init();
    await FetchTime(static);
    await FetchData(static);
  }
  Future<void> FetchData(String static) async {
    final response = await http
        .get(Uri.parse('https://io.adafruit.com/api/v2/$User/feeds/$static/data?start_time=$timeStart&end_time=$timeEnd'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      fromJson(jsonDecode(response.body));

    }
  }
  void fetchTimeJson(List<dynamic> json) {
    timeEnd=(json[0]["created_epoch"]+1).toString();
    timeStart=(int.parse(timeEnd)-600).toString();
    timeLastData=(json[0]["created_epoch"]).toString();//25200 to convert current timezone in VN
    timeLastDataString=DateTime.fromMillisecondsSinceEpoch(int.parse(timeLastData)*1000).toString();
    print(DateTime.fromMillisecondsSinceEpoch(int.parse(timeLastData)*1000).toString());
    //print(timeStart);
  }
  Future<void> FetchTime(String static) async {
    final response = await http
        .get(Uri.parse('https://io.adafruit.com/api/v2/$User/feeds/$static/data?limit=1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      fetchTimeJson(jsonDecode(response.body));

    }
  }
}
