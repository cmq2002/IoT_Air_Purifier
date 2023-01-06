import 'package:AirCleaner/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
Widget numberContent(Future<void> Function() _refreshLocalGallery, List<String> unit) {
  return RefreshIndicator(onRefresh: _refreshLocalGallery,
      child: Stack(children: [
        GridView.builder(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: icn.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(color: white, boxShadow: defaultBoxShadow(), borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.all(Radius.circular(10))),
                        child:Column(
                            children:[
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xC4C4BCEA),
                                ),
                                child:Icon(icn[index]),
                              ),
                              SizedBox(height:10),
                              Text (des[index]),
                              SizedBox(height:10),
                              Text (unit[index]),
                            ]

                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ListView(
          physics: const AlwaysScrollableScrollPhysics(),
        ),
      ]
      )
  );
}
List<IconData> icn=[Icons.warning_amber_outlined,Icons.waves_outlined ,Icons.device_thermostat,Icons.water_drop];
List<String> des=["Harmful Gas","PM 2.5 Dust","Temperature","Humidity"];
