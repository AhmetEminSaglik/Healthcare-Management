import 'package:blood_check/Pages/CustomWidgets/CheckBoxVisibleBloodResultContent.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/predata/BaseLineChartPreData.dart';
import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/model/enums/bloodresult/EnumBloodResultContent.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

abstract class BaseLineChart extends StatelessWidget {
  late double _aspectRadio;
  late BaseLineChartPreData _baseLineChartPreData;
  late CheckBoxVisibleBloodResultContent _checkBoxVisibleBloodResultContent;
  late bool isVisibleBloodSugar;
  late bool isVisibleBloodPressure;
  late bool isVisibleCalcium;
  late bool isVisibleMagnesium;
  bool _showFlDotData = false;
  String _extraMsg = "";

  BaseLineChart(
      {required BaseLineChartPreData baseLineChartPreData,
      required CheckBoxVisibleBloodResultContent
          checkBoxVisibleBloodResultContent,
      double aspectRadio = 1.40}) {
    _baseLineChartPreData = baseLineChartPreData;
    _checkBoxVisibleBloodResultContent = checkBoxVisibleBloodResultContent;
    _aspectRadio = aspectRadio;
  }

  void updateVisibleValues() {
    isVisibleBloodSugar = _checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.BLOOD_SUGAR.name]!.showContent;
    isVisibleBloodPressure = _checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.BLOOD_PRESSURE.name]!.showContent;
    isVisibleCalcium = _checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.CALCIUM.name]!.showContent;
    isVisibleMagnesium = _checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.MAGNESIUM.name]!.showContent;
  }

  Widget showDataIsNotFoundText() {
    if (_baseLineChartPreData.bloodResultList.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: ResponsiveDesign.getScreenHeight() / 50),
        child: Container(
          color: ProductColor.redAccent,
          height: ResponsiveDesign.getScreenHeight() / 15,
          width: ResponsiveDesign.getScreenWidth() -
              ResponsiveDesign.getScreenWidth() / 3.5,
          child: Center(
            child: Text(
              "Data Is Not Found",
              style: TextStyle(
                fontSize: ResponsiveDesign.getScreenWidth() / 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget showExtraMsgTopOfLineChart({String msg = "Default  Msg"}) {
    if (msg.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: ResponsiveDesign.getScreenHeight() / 50),
        child: Container(
          color: ProductColor.redAccent,
          height: ResponsiveDesign.getScreenHeight() / 15,
          width: ResponsiveDesign.getScreenWidth() -
              ResponsiveDesign.getScreenWidth() / 3.5,
          child: Center(
            child: Text(
              msg,
              style: TextStyle(
                  fontSize: ResponsiveDesign.getScreenWidth() / 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    updateVisibleValues();
    return Scaffold(
      // backgroundColor:ProductColor.bodyBackgroundLight,
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: ResponsiveDesign.getCertainWidth() / 10),
            child: Column(
              children: [
                showDataIsNotFoundText(),
                showExtraMsgTopOfLineChart(msg: _extraMsg),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: ResponsiveDesign.getScreenWidth() / 30,
                right: ResponsiveDesign.getScreenWidth() / 30,
                top: ResponsiveDesign.getScreenWidth() / 10,
                bottom: ResponsiveDesign.getScreenWidth() / 10,
              ),
              child:
                  LineChart(getLineChartData()), //LineChart(lineChartData()),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData getLineChartData();

  bool get showFlDotData => _showFlDotData;

  set showFlDotData(bool value) {
    _showFlDotData = value;
  }

  String get extraMsg => _extraMsg;

  set extraMsg(String value) {
    _extraMsg = value;
  }

  BaseLineChartPreData get baseLineChartPreData => _baseLineChartPreData;

  double get aspectRadio => _aspectRadio;

  set aspectRadio(double value) {
    _aspectRadio = value;
  }

  LineChartBarData getBloodSugarLineChartBarData() {
    List<FlSpot> spotsBloodSugar = [];
    for (FlSpot tmp
        in _baseLineChartPreData.bloodListSubItemsFlSpot.bloodSugarList) {
      spotsBloodSugar.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodSugar, color: ProductColor.fLSpotColorBloodSugar);
  }

  LineChartBarData getBloodPressureLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp
        in _baseLineChartPreData.bloodListSubItemsFlSpot.bloodPressureList) {
      spotsBloodPressure.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodPressure,
        color: ProductColor.fLSpotColorBloodPressure);
  }

  LineChartBarData getMagnesiumLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp
        in _baseLineChartPreData.bloodListSubItemsFlSpot.magnesiumList) {
      spotsBloodPressure.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodPressure,
        color: ProductColor.fLSpotColorMagnesium);
  }

  LineChartBarData getCalciumLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp
        in _baseLineChartPreData.bloodListSubItemsFlSpot.calciumList) {
      spotsBloodPressure.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodPressure, color: ProductColor.fLSpotColorCalcium);
  }

  LineChartBarData _getLineChartBarDataForSubBloodResultItem(
      {required List<FlSpot> spotValues, required Color color}) {
    return LineChartBarData(
        color: color,
        isCurved: false,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: _showFlDotData),
        spots: spotValues);
  }

  Widget getBottomSideTiles(double value, TitleMeta meta) {
    String text = "";
    for (int i = 0; i < _baseLineChartPreData.bottomTitle.length; i++) {
      if (value == _baseLineChartPreData.bottomTitle[i].index) {
        text = _baseLineChartPreData.bottomTitle[i].text;
        break;
      }
    }
    return Text(
      text,
      style: axisTextStyle(),
      textAlign: TextAlign.left,
    );
  }

  Widget getLeftSideTiles(double value, TitleMeta meta) {
    String text = "";
    for (int i = 0; i < _baseLineChartPreData.leftTitle.length; i++) {
      if (value == _baseLineChartPreData.leftTitle[i].index) {
        text = _baseLineChartPreData.leftTitle[i].text;
        break;
      }
    }
    return Text(
      text,
      style: axisTextStyle(),
      textAlign: TextAlign.left,
    );
  }

  TextStyle axisTextStyle() {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red);
  }

  LineChartBarData getLineChartBarData(
      {required bool visible, required LineChartBarData lineChartBarData}) {
    if (visible) {
      return lineChartBarData;
    } else {
      return LineChartBarData();
    }
  }
}
