import 'dart:async';

import 'package:AirCleaner/Body/screen/ChartBody/screen/ChartBodyScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:AirCleaner/Body/model/db4/Db4Model.dart';

import '../../config.dart';
import '../../main.dart';
import '../../main/utils/AppColor.dart';
import '../../widgets/Slider.dart';
import 'ControlBody/screen/ControlBody.dart';
import 'ProfileBody/screen/ProfileBody.dart';

class Main extends StatefulWidget {

  @override
  MainState createState() => MainState();
}

List<ButtonCategory>? HomeButtonList;
List<ButtonCategory>? ProfileButtonList;
List<Db4Slider>? mSliderList;
final GlobalKey<ScaffoldState> HomeKey = GlobalKey<ScaffoldState>();
class MainState extends State<Main> {
  bool passwordVisible = false;
  bool isRemember = false;
  bool On=false;
  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    init();
  }
  init() async {
    await Future.delayed(Duration(seconds: 1));
    HomeKey.currentState!.openDrawer();
  }
  var currentIndexPage = 0;

  List<IconData> navbarIcons = [Icons.home,Icons.bar_chart, Icons.settings_remote];
  List appBars= [
    null,
    AppBar(title:Text("Chart",style: TextStyle(color:Colors.black,),),automaticallyImplyLeading: false,backgroundColor:db4_colorPrimary),
    AppBar(title:Text("Static",style: TextStyle(color:Colors.black),),automaticallyImplyLeading: false,backgroundColor:db4_colorPrimary),
  ];
  List floatingButtons= [
    null,
    null,
    null,
  ];
  List<String> bottomNavigationName = ['Home','Chart and Statistic', 'Info'];

  List<Color> color = [Colors.blue,Colors.orange, Colors.purple];

  List<Color> colorShade = [Colors.blue.shade100,Colors.orange.shade100, Colors.purple.shade100];

  int selectedIndex = 0;
  double _currentSliderValue = 20;
  bool Notiflag=false;
  int Cooldown=timeInterval;
  @override

  Widget build(BuildContext context) {
    Widget OnSwitch=FlutterSwitch(
      activeText: "ON",
      inactiveText: "OFF",
      activeColor: Colors.lightGreen,
      inactiveColor: Colors.red,
      value: On,
      valueFontSize: 20.0,
      height: 100,
      width: 400,
      borderRadius: 30.0,
      showOnOff: true,
      onToggle: (val) async {
        setState(() {
          On = val;

        });
        await number.addNumber("status",On);
      },
    );
    Widget SpeedSlider=Column(
    children:[
      Text("Change fan speed"),
      Slider(
      value: _currentSliderValue,
      max: 100,
      divisions: 100,
      label: _currentSliderValue.round().toString()+"RPM",
      onChanged:!On ?null: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
        onChangeEnd:!On ?null: (double value) async {
            await number.changeSpeed("propeller-speed",_currentSliderValue.toString());
        },
    )
    ]
    );
    List<String> unit=[number.harmful+" ppm",number.dust+" mg/m3",number.temperature+" °C",number.humidity+" %"];
    Future<void> Cool()async {
      if(Notiflag==true)Cooldown--;
     // print(Cooldown);
    }
    Future<void> SetFlag()async {
      if(Cooldown<=0){
        Cooldown=timeInterval;
        Notiflag=false;
      }
    }
    Future<void> ShowNoti()async {
      if (number.harmful.toDouble() > overHarmful && Notiflag == false) {
        await showNotification();
        Notiflag = true;
      }
      if (number.dust.toDouble() > overDust && Notiflag == false) {
        await showNotification();
        Notiflag = true;
      }
    }
    final Stream<int> _stream = (() {
      late final StreamController<int> controller;
      controller = StreamController<int>(
        onListen: () async {
             await ShowNoti();
             await Cool();
             await SetFlag();
             await number.fetchNumber();
             await Future<void>.delayed(const Duration(seconds: 1));
             setState(() {
                unit=[number.harmful+" ppm",number.dust+" mg/m3",number.temperature+" °C",number.humidity+" %"];
              });
             await controller.close();
        },
      );
      return controller.stream;
    })();

    Future<void> _refreshLocalGallery() async{
      await number.fetchNumber();
      setState(() {
        unit=[number.harmful+" ppm",number.dust+" mg/m3",number.temperature+" °C",number.humidity+" %"];

      });
      return Future<void>.delayed(const Duration(seconds: 2));
    }
    Future<void> _refreshChart() async{
      await humidChart.fetchData("humid");
      await harmfulChart.fetchData("harmful-gas");
      await tempChart.fetchData("temp");
      await dustChart.fetchData("pm2-dot-5");
      chartType=[humidChart,harmfulChart,tempChart,dustChart];
      return Future<void>.delayed(const Duration(seconds: 2));

    }
    List<Widget> Bodies =[ProfileBody(OnSwitch,SpeedSlider),ChartBody(_refreshChart),numberContent(_refreshLocalGallery,unit),Center()];
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
      return DefaultTabController(
        length: 12,
        child:Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButton: floatingButtons[selectedIndex],
          drawer: draw(HomeKey),
          key: HomeKey,
          appBar: appBars[selectedIndex],
          backgroundColor: db4_colorPrimary,
          body: StreamBuilder(
            stream:_stream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                if (snapshot.hasError){

                }
            return Bodies[selectedIndex];
          }),
          bottomNavigationBar:Container(
            padding: EdgeInsets.only(bottom: 16, left: 12, right: 12, top: 8),
            height: 70,
            decoration: boxDecorationDefault(borderRadius: radius(0), color: context.cardColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: navbarIcons.map(
                    (e) {
                  int i = navbarIcons.indexOf(e);
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    padding: EdgeInsets.all(8),
                    height: 45,
                    decoration: BoxDecoration(
                      color: i == selectedIndex ? colorShade[i] : context.cardColor,
                      borderRadius: radius(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          e,
                          size: 30,
                          color: i == selectedIndex ? color[i] : Colors.blueGrey[300],
                        ).onTap(
                              () {
                            selectedIndex = i;
                            setState(() {});
                          },
                          splashColor: context.cardColor,
                        ),
                        Text(bottomNavigationName[i], style: boldTextStyle(color: color[i])).paddingSymmetric(horizontal: 4).visible(i == selectedIndex),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
      ),

      );

      }
}


