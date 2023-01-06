import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:AirCleaner/main/utils/AppWidget.dart';
import '../../../../main.dart';
import '../utils/T1Constant.dart';
import '../utils/T1Widget.dart';
  Widget counter(String counter, String counterName) {
    return Column(
      children: <Widget>[
        profile(counter),
        text(counterName, fontSize: textSizeMedium, fontFamily: fontMedium),
      ],
    );
  }

  Widget profileImg = Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: CircleAvatar(
        backgroundColor: white,
        backgroundImage:ExactAssetImage("images/cleanair.jpg"),
        radius: 50,
      ),
    );
  Widget deviceContent(Widget OnButton) {
   return Container(
      margin: EdgeInsets.only(top: 55.0),
      decoration: boxDecoration(radius: 10, showShadow: true),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            text(data.name, fontSize: textSizeNormal, fontFamily: fontMedium),
            text(
                data.version, fontSize: textSizeMedium, fontFamily: fontMedium),
            Padding(
              padding: EdgeInsets.all(16),
              child: Divider(height: 0.5),
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 8),
                rowHeading("Device control"),
                SizedBox(height: 8),
                OnButton,
                SizedBox(height: 8),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget ProfileBody(Widget OnButton, Widget SpeedSlider) {
  return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Stack(
                    children: <Widget>[deviceContent(OnButton), profileImg],
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SpeedSlider,
                  ),
                ),
                SizedBox(height: 16),
              ],
  );}
