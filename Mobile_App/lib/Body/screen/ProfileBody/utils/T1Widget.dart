import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:AirCleaner/main/utils/AppWidget.dart';

import '../../../../main/utils/AppConstant.dart';
import 'T1Colors.dart';


//-------------------------------------------Other-------------------------------------------------------------------------
Row rowHeading(var label) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 10, 0),
        child: Text(label, style: TextStyle(fontSize: 18, fontFamily: 'Bold'), textAlign: TextAlign.left),
      ).center(),
    ],
  );
}

Row profileText(var label, {var maxline = 1}) {
  return Row(
    children: <Widget>[
      Padding(padding: const EdgeInsets.fromLTRB(20, 0, 10, 0), child: text(label, fontSize: textSizeLargeMedium,maxLine: maxline)),
    ],
  );
}

Text profile(var label) {
  return Text(label, style: TextStyle(fontSize: 18, fontFamily: 'Medium'), textAlign: TextAlign.center);
}

//-------------------------------------------View-------------------------------------------------------------------------
Divider view() {
  return Divider( height: 0.5);
}
//-----------------------------------------------List------------------------------------------------------------


Text headerText(var text) {
  return Text(
    text,
    maxLines: 2,
    style: TextStyle(fontFamily: fontBold, fontSize: 22),
  );
}

// ignore: must_be_immutable
class AppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  AppButton({required this.textContent, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return AppButtonState();
  }
}

class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: t1_white),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
      ),
      onPressed: widget.onPressed,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.textContent,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable

