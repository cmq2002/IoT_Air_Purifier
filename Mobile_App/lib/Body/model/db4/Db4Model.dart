import 'dart:ui';
import 'dart:convert';

import 'package:flutter/services.dart';
class ButtonCategory {
  var name = "";
  Color? backcolor;
  Color? frontcolor;
  var icon = "";
}

class Db4Slider {
  var image = "";
  var balance = "";
  var accountNo = "";
}
class Data {
  String name="";
  String version="";
// A function that converts a response body into a List<Photo>.
  Future<void> readJsondata() async {
    final String response = await rootBundle.loadString('json/data.json');
    final data = await json.decode(response);
    name=data["id"]["name"];
    version=data["id"]["mail"];
    print(name);
  }
}

