import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../main.dart';
import '../../../../main/utils/AppConstant.dart';
import '../../../../main/utils/AppWidget.dart';
import '../model/ChartBodyModel.dart';
import '../utils/ChartColor.dart';
List<Color> gradientColor = [lineCChart, lineCChart1];
List<Chart> chartType=[humidChart,harmfulChart,tempChart,dustChart];
List<String> title=["humidChart","harmfulChart","tempChart","dustChart"];
Widget chartTitle(int a){
  return text(title[a], fontSize: textSizeNormal,
      fontFamily: fontMedium,
      textColor: Colors.black);
}
Widget chartTime(int a){
  return text("(Last value :"+chartType[a].timeLastDataString+")", fontSize: textSizeNormal,
      fontFamily: fontMedium,
      textColor: Colors.black);
}
Widget chartImage(int a){
  return
  Column(children:[
    chartTitle(a),
    chartTime(a),
    Container(
    color: white,
    padding: EdgeInsets.only(right: 16),
    height: 450,
    width: 400,
    child: LineChart(
      LineChartData(
        minX: 0,
        maxX: 600,
        minY: 0,
        maxY: 100,
        titlesData: LineTitles.getTitleData(),
        gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: borderText.withOpacity(0.3),
                strokeWidth: 1,
              );
            },
            drawVerticalLine: true),
        borderData: FlBorderData(
            border: Border.all(color: borderText, width: 1)),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for(int i = 0; i < chartType[a].timeScale.length; i++)FlSpot(
                  chartType[a].timeScale[i].toDouble(),
                  chartType[a].data[i].toDouble()),
            ],
            isCurved: false,
            colors: gradientColor,
            barWidth: 1,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
                show: true,
                colors: gradientColor.map((e) {
                  return e.withOpacity(0.3);
                }).toList()),
          ),
        ],
      ),
    ),
  )]).center();
}

Widget ChartBody(Future<void> Function() _refreshLocalGallery){
  return RefreshIndicator(onRefresh: _refreshLocalGallery,
      child: Stack(children: [SingleChildScrollView(
child:Column(
  children:[
    for (int i=0;i<4;i++)chartImage(i),

  ]))
  ]));
}



class LineTitles {
  static getTitleData() => FlTitlesData(
    leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context) => primaryTextStyle(color: borderText),
        getTitles: (val) {
          switch (val.toInt()) {
            case 20:
              return '20';
            case 40:
              return '40';
            case 60:
              return '60';
            case 80:
              return '80';
            case 100:
              return '100';
          }
          return '';
        },
        reservedSize: 35),
    show: true,
    bottomTitles: SideTitles(
      getTextStyles: (context) => boldTextStyle(color: borderText),
      showTitles: true,
      margin: 8,
      reservedSize: 38,
      getTitles: (val) {
        if(val.toInt()%300==0)return val.toString();
        else return '';
      },
    ),
  );
}
