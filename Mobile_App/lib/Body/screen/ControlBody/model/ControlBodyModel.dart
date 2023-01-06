import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../config.dart';

class Number {
  String harmful='X';
  String dust='X';
  String temperature='X';
  String humidity='X';

  String fromJson(List<dynamic> json) {
    //print(json[0]['value'].toString());
    return json[0]['value'].toString();
  }
  changeSpeed(String static,String value) async{
    var url = Uri.parse('https://io.adafruit.com/api/v2/$User/feeds/$static/data');
    var req = new http.MultipartRequest('POST', url)
      ..fields['value'] = value;
    req.headers['X-AIO-Key'] = Key;
    var res = await req.send();
    if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
  }
  addNumber(String static,bool signal) async{
    String value='0';
    if(signal)value='1';
    var url = Uri.parse('https://io.adafruit.com/api/v2/$User/feeds/$static/data');
    var req = new http.MultipartRequest('POST', url)
      ..fields['value'] = value;
    req.headers['X-AIO-Key'] = Key;
    var res = await req.send();
    if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
  }
  fetchNumber() async{
    harmful=await FetchNumber("harmful-gas");
    dust=await FetchNumber("pm2-dot-5");
    temperature=await FetchNumber("temp");
    humidity= await FetchNumber("humid");
  }
  Future<String> FetchNumber(String static) async {
    final response = await http
        .get(Uri.parse('https://io.adafruit.com/api/v2/$User/feeds/$static/data'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
     return fromJson(jsonDecode(response.body));

    }
    return "X";
  }
}
