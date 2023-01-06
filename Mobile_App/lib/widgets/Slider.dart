import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../config.dart';
import '../main.dart';
import '../main/utils/AppColor.dart';
final myController = TextEditingController();
Widget draw(GlobalKey<ScaffoldState> _scaffoldKey) {

    Widget itemList(Widget icon, String title) {
      return Container(
          child:Row(
        children: [
          icon,
          10.width,
          Text(title),
        ],
      ).onTap(() {
        _scaffoldKey.currentState!.openEndDrawer();
      }));
    }
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
            color:db4_colorSlider,
          ),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(8),
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Colors.orange),
                      image: DecorationImage(image: ExactAssetImage(
                          "images/cleanair.jpg")),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(data.name, style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w600)),
                  Text(data.version, style: TextStyle(fontSize: 16.0)),
                  30.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: myController,
                      onChanged: (String text){
                        User=myController.text;
                        print(myController.text);
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        hintText: 'Enter user',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4), size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}