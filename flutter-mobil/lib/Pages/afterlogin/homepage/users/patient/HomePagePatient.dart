import 'dart:convert';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:blood_check/Pages/CustomWidgets/CheckBoxVisibleBloodResultContent.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/BaseLineChart.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/LineChart6Monthly.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/LineChartDaily.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/LineChartMonthly.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/LineChartWeekly.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/predata/BaseLineChartPreData.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/predata/LineChartPreDataDaily.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/predata/LineChartPreDataMonthly.dart';
import 'package:blood_check/Pages/CustomWidgets/linechart/predata/LineChartPreDataWeekly.dart';
import 'package:blood_check/Product/CustomText.dart';
import 'package:blood_check/business/QRCodeScanner.dart';
import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/httprequest/HttpRequestBloodResult.dart';
import 'package:blood_check/httprequest/HttpRequestDoctor.dart';
import 'package:blood_check/httprequest/HttpRequestPatient.dart';
import 'package:blood_check/httprequest/ResponseEntity.dart';
import 'package:blood_check/model/bloodresult/BloodResult.dart';
import 'package:blood_check/model/bloodresult/CheckboxBloodResultSubItem.dart';
import 'package:blood_check/model/enums/bloodresult/EnumBloodResultContent.dart';
import 'package:blood_check/model/firebase/FcmNotificationCubit.dart';
import 'package:blood_check/model/specialitem/doctor/PatientTimer.dart';
import 'package:blood_check/model/specialitem/doctor/PatientTimerWidget.dart';
import 'package:blood_check/util/AppBarUtil.dart';
import 'package:blood_check/util/CustomAlertDialog.dart';
import 'package:blood_check/util/CustomSnackBar.dart';
import 'package:blood_check/util/FcmTokenUtils.dart';
import 'package:blood_check/util/IndexColorUtil.dart';
import 'package:blood_check/util/PatientTimerUtils.dart';
import 'package:blood_check/util/PermissionUtils.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'DetailLineChartCubit.dart';
import 'DetailLineChartPage.dart';

class HomePagePatient extends StatefulWidget {
  final String displayNamePatientPage;
  final int patientId;

  const HomePagePatient(
      {super.key,
      required this.displayNamePatientPage,
      required this.patientId});

  @override
  State<HomePagePatient> createState() => _HomePagePatientState();
}

class _HomePagePatientState extends State<HomePagePatient> {
  static var log = Logger(printer: PrettyPrinter(colors: false));
  Color btnTextColor = ProductColor.black;
  Color btnBackgroundColor = ProductColor.bodyBackground;

  String QRCodeData = "";
  late BaseLineChart activatedBaseLineChart;

  bool visibleAppBar =
      PermissionUtils.letRunForAdmin() || PermissionUtils.letRunForDoctor();
  bool visiblePatientTimer = PermissionUtils.letRunForDoctor();
  bool visibleQrScanner = PermissionUtils.letRunForPatient();
  bool isLoading = true;
  List<BloodResult> dailyBloodResultList = [];
  List<BloodResult> weeklyBloodResultList = [];
  List<BloodResult> monthlyBloodResultList = [];
  PatientTimer patientTimer = PatientTimer();
  final double smallLineChartAspectRadio = 2.5;
  final double smallLineChartHeight = ResponsiveDesign.getScreenHeight();
  final double bigLineChartHeight =
      100; //ResponsiveDesign.getScreenHeight()-ResponsiveDesign.getScreenHeight()/3;
  double bigLineChartAspectRadio = 1.8;

  bool showBloodSugar = true;
  bool showBloodPressure = false;
  int radioValue = 1;

  final CheckBoxVisibleBloodResultContent _checkBoxVisibleBloodResultContent =
      CheckBoxVisibleBloodResultContent();
  late BaseLineChartPreData _lineChartPreDataDaily;
  late BaseLineChartPreData _lineChartPreDataWeekly;
  late BaseLineChartPreData _lineChartPreDataMonthly;
  late BaseLineChartPreData _lineChartPreData6Monthly;
  bool isDataFound = false;

  void updateActivatedLineChart(int selectedRadioValue) {
    switch (selectedRadioValue) {
      case 1:
        activatedBaseLineChart = LineChartDaily(
            baseLineChartPreData: _lineChartPreDataDaily,
            checkBoxVisibleBloodResultContent:
                _checkBoxVisibleBloodResultContent,
            aspectRadio: smallLineChartAspectRadio);
        break;
      case 2:
        activatedBaseLineChart = LineChartWeekly(
            baseLineChartPreData: _lineChartPreDataWeekly,
            checkBoxVisibleBloodResultContent:
                _checkBoxVisibleBloodResultContent,
            aspectRadio: smallLineChartAspectRadio);
        break;
      case 3:
        activatedBaseLineChart = LineChartMonthly(
            baseLineChartPreData: _lineChartPreDataMonthly,
            checkBoxVisibleBloodResultContent:
                _checkBoxVisibleBloodResultContent,
            aspectRadio: smallLineChartAspectRadio);
        break;
      case 4:
        activatedBaseLineChart = LineChart6Monthly(
          baseLineChartPreData: _lineChartPreDataMonthly,
          checkBoxVisibleBloodResultContent: _checkBoxVisibleBloodResultContent,
        );
        break;
    }
    context
        .read<DetailLineChartCubit>()
        .updateBaseLineChart(activatedBaseLineChart);
    setState(() {});
  }

  bool assignEmptyLineChart(List list) {
    if (list.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    retrieveBloodResultData();
    retrievePatientTimerData();
    FcmTokenUtils.updatePatientId(widget.patientId);
  }

  void retrievePatientTimerData() async {
    patientTimer =
        await HttpRequestPatient.retrievePatientTimer(widget.patientId);
    log.i("retrievePatientTimerData() > patientTimer  : $patientTimer ");
    log.i("2222222222 : $patientTimer ");
  }

  void retrieveBloodResultData() async {
    dailyBloodResultList =
        await HttpRequestBloodResult.getDailyBloodResult(widget.patientId);
    weeklyBloodResultList =
        await HttpRequestBloodResult.getWeeklyBloodResult(widget.patientId);
    monthlyBloodResultList =
        await HttpRequestBloodResult.getMonthlyBloodResult(widget.patientId);

    _lineChartPreDataDaily =
        LineChartPreDataDaily(bloodResultList: dailyBloodResultList);
    _lineChartPreDataWeekly =
        LineChartPreDataWeekly(bloodResultList: weeklyBloodResultList);
    _lineChartPreDataMonthly =
        LineChartPreDataMonthly(bloodResultList: monthlyBloodResultList);

    if (dailyBloodResultList.isNotEmpty ||
        weeklyBloodResultList.isNotEmpty ||
        monthlyBloodResultList.isNotEmpty) {
      isDataFound = true;
    }
    isLoading = false;
    updateActivatedLineChart(radioValue);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    context.read<FcmNotificationCubit>().disableUpdatingPatientPage();
  }

  @override
  Widget build(BuildContext context) {
    context.read<FcmNotificationCubit>().enableUpdatingPatientPage();
    log.i("Homepage Patient build ");
    return Scaffold(
      appBar: visibleAppBar ? AppBarUtil.getAppBar() : null,
      backgroundColor:
          isLoading ? ProductColor.bodyBackground : ProductColor.white,
      body: isLoading
          ? const LoadingScreenWidget()
          : BlocBuilder<FcmNotificationCubit, bool>(
              builder: (builder, refreshLineChart) {
              context
                  .read<FcmNotificationCubit>()
                  .disableUpdatePatientLineChart();
              if (refreshLineChart) {
                retrieveBloodResultData();
                refreshLineChart = false;
              }
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    QRCodeData.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: ResponsiveDesign.getScreenHeight() / 50,
                                bottom: ResponsiveDesign.getScreenHeight() / 50,
                                left: ResponsiveDesign.getScreenHeight() / 50,
                                right: ResponsiveDesign.getScreenHeight() / 50),
                            child: CustomText(
                              text1: "Activated QR",
                              text2: "$QRCodeData",
                              fontSize: ResponsiveDesign.getScreenWidth() / 22,
                            ),
                          )
                        : Container(),
                    // Text("counter $counter"),
                    Container(
                      height: ResponsiveDesign.getScreenHeight() / 7,
                      color: ProductColor.bodyBackground,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ResponsiveDesign.getScreenHeight() / 75),
                          child: Column(
                            children: [
                              // getActivatedQRText(QRCodeData),
                              BlocBuilder<FcmNotificationCubit, bool>(
                                builder: (builder, refreshSensorTimer) {
                                  context
                                      .read<FcmNotificationCubit>()
                                      .disableUpdateSensorTimer();
                                  if (refreshSensorTimer) {
                                    retrievePatientTimerData();
                                    refreshSensorTimer = false;
                                    log.i("Sensor Timer Updatelendi");
                                  }
                                  // setState(() {});
                                  return SensorTimerText(
                                      patientTimer: patientTimer);
                                },
                              ),

                              SensorNextMeasurementText(
                                  dailyBloodResultList: dailyBloodResultList,
                                  patientTimer: patientTimer),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveDesign.getScreenHeight() / 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                getBloodResultRadioButtonTime(
                                    name: "Daily", itemValue: 1),
                                getBloodResultRadioButtonTime(
                                    name: "Monthly", itemValue: 3),
                              ],
                            ),
                            Column(
                              children: [
                                getBloodResultRadioButtonTime(
                                    name: "Weekly", itemValue: 2),
                                getBloodResultRadioButtonTime(
                                    name: "6 Month", itemValue: 4),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                            width: ResponsiveDesign.getScreenWidth(),
                            child: Center(
                              child: Row(
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getCheckboxBloodResultItem(
                                          bloodResultSubItemCheckbox:
                                              _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .BLOOD_SUGAR.name]!,
                                          itemColor: ProductColor
                                              .fLSpotColorBloodSugar,
                                        ),
                                        getCheckboxBloodResultItem(
                                          bloodResultSubItemCheckbox:
                                              _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .CALCIUM.name]!,
                                          itemColor:
                                              ProductColor.fLSpotColorCalcium,
                                        ),
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getCheckboxBloodResultItem(
                                          bloodResultSubItemCheckbox:
                                              _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .BLOOD_PRESSURE.name]!,
                                          itemColor: ProductColor
                                              .fLSpotColorBloodPressure,
                                        ),
                                        getCheckboxBloodResultItem(
                                          bloodResultSubItemCheckbox:
                                              _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .MAGNESIUM.name]!,
                                          itemColor:
                                              ProductColor.fLSpotColorMagnesium,
                                        ),
                                      ]),
                                ],
                              ),
                            )),
                      ],
                    ),

                    Column(
                      children: [
                        _getPatientTimerButton(),
                        _getQRScannerButton(),
                        _getDetailedLineChartButton(),
                        _getLineChart(),
                      ],
                    ),
                  ],
                ),
              );
            }),
    );
  }

  void goToDetailedPage() {
    activatedBaseLineChart.aspectRadio = bigLineChartAspectRadio;
    AutoOrientation.landscapeAutoMode();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailLineChartPage(
                  baseLineChart: activatedBaseLineChart,
                ))).then((value) => AutoOrientation.portraitAutoMode());
  }

  void scanQRCode() async {
    await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QRCodeScanner()))
        .then((value) => {QRCodeData = value});
    setState(() {});
  }

  Padding getBloodResultRadioButtonTime(
      {required String name, required int itemValue}) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveDesign.getScreenWidth() / 100),
      child: SizedBox(
        width: ResponsiveDesign.getScreenWidth() * 2 / 5,
        child: RadioListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            name,
            style: TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 20),
          ),
          value: itemValue,
          groupValue: radioValue,
          contentPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveDesign.getScreenWidth() / 100,
          ),
          onChanged: (int? value) {
            radioValue = value!;
            updateActivatedLineChart(radioValue);
          },
        ),
      ),
    );
  }

  Widget getCheckboxBloodResultItem({
    required CheckboxBloodResultSubItem bloodResultSubItemCheckbox,
    required Color itemColor,
  }) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 2,
      child: CheckboxListTile(
          activeColor: itemColor,
          title: Text(
            bloodResultSubItemCheckbox.name,
            style: TextStyle(
                fontSize: ResponsiveDesign.getScreenWidth() / 22,
                color: itemColor),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: bloodResultSubItemCheckbox.showContent,
          onChanged: (bool? condition) {
            bloodResultSubItemCheckbox.showContent = condition!;
            updateActivatedLineChart(radioValue);
          }),
    );
  }

  Widget _getPatientTimerButton() {
    if (visiblePatientTimer) {
      return _CustomButton(
          action: showAlertDialogSetUpPatientTimer,
          text: "Set Patient Timer",
          color: ProductColor.white,
          backgroundColor: ProductColor.black);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _getQRScannerButton() {
    if (visibleQrScanner) {
      return _CustomButton(
        action: scanQRCode,
        text: 'Scan QR Code',
        color: ProductColor.white,
        backgroundColor: ProductColor.bodyBackground,
      );
    }
    return Container();
  }

  Widget _getDetailedLineChartButton() {
    if (isDataFound) {
      return _CustomButton(
        action: goToDetailedPage,
        text: 'Detail LineChart',
        color: ProductColor.white,
        backgroundColor: ProductColor.pink,
      );
    }
    return Container();
  }

  Widget _getLineChart() {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveDesign.getScreenWidth() / 50,
        right: ResponsiveDesign.getScreenWidth() / 10,
      ),
      child: SizedBox(
          height: ResponsiveDesign.getScreenHeight() / 2.55,
          child: activatedBaseLineChart),
    );
  }

  void showAlertDialogSetUpPatientTimer() async {
    var resp = await showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogSetUpPatientTimer(
              patientTimerWidget: PatientTimerWidget(),
              context: context,
            ));
    if (resp != null && resp.result) {
      resp.patientTimer.patientId = widget.patientId;
      sendRequestToSavePatientTimer(resp.patientTimer);
      patientTimer = resp.patientTimer;
      // retrievePatientTimerData();
      setState(() {});
    } else {
      String msg = "Patient Timer setup is cancelled";
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.getSnackBar(msg));
    }
  }

  void sendRequestToSavePatientTimer(PatientTimer patientTimer) async {
    var resp = await HttpRequestDoctor.savePatientTimer(patientTimer);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    String msg;
    if (respEntity.success) {
      msg = "Timer is updated Successfully.";
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.getSnackBar(msg));
    } else {
      msg = "FAILED :\n${respEntity.message}";
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.getSnackBar(msg));
    }
  }
}

int customBtnCounter = 0;

class _CustomButton extends StatelessWidget {
  late final Function() action;
  late final String text;
  late final Color color;
  late final Color backgroundColor;

  _CustomButton(
      {required this.action,
      required this.text,
      /* required this.*/ color,
      /*required this.*/ backgroundColor}) {
    if (color == null || backgroundColor == null) {
      this.color = ButtonItemColor.getTextColor(index: customBtnCounter);
      this.backgroundColor =
          ButtonItemColor.getBackgroundColor(index: customBtnCounter);
      customBtnCounter++;
    } else {
      this.color = color;
      this.backgroundColor = backgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveDesign.getScreenWidth() -
          ResponsiveDesign.getScreenWidth() / 3,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
          onPressed: action,
          child: Text(
            text,
            style: TextStyle(
                fontSize: ResponsiveDesign.getScreenHeight() / 40,
                color: color,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}

class SensorNextMeasurementText extends StatelessWidget {
  const SensorNextMeasurementText({
    super.key,
    required this.dailyBloodResultList,
    required this.patientTimer,
  });

  final List<BloodResult> dailyBloodResultList;
  final PatientTimer patientTimer;

  String _getStringDataToShow() {
    if (dailyBloodResultList.isNotEmpty) {
      return "Next Time : ${PatientTimerUtils.calculateSensorNextMeasurementTime(lastCreatedAt: dailyBloodResultList[0].createdAt, patientTimer: patientTimer)}";
    }
    return "Not found record Blood Result";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveDesign.getScreenWidth() / 10,
        right: ResponsiveDesign.getScreenWidth() / 10,
        // top: ResponsiveDesign.getScreenHeight() / 50,
      ),
      child: Container(
        width: ResponsiveDesign.getScreenWidth(),
        height: ResponsiveDesign.getScreenHeight() / 25,
        // color: ProductColor.white,
        child: Center(
          child: _InfoTextDesign(text: _getStringDataToShow()),
          /*Text(
              */ /*"Next Time : ${PatientTimerUtils.calculateSensorNextMeasurementTime(lastCreatedAt: dailyBloodResultList[0].createdAt, patientTimer: patientTimer)}"*/ /*
              _getStringDataToShow(),
              style: TextStyle(
                  fontSize: ResponsiveDesign.getScreenWidth() / 20,
                  // color: ProductColor.bodyBackground,
                  fontWeight: FontWeight.bold)),*/
        ),
      ),
    );
  }
}

Widget getActivatedQRText(String QRCodeData) {
  return QRCodeData.isNotEmpty
      ? _InfoTextDesign(text: "Activated QR : $QRCodeData")
      : Container();
}

class SensorTimerText extends StatelessWidget {
  const SensorTimerText({
    super.key,
    required this.patientTimer,
  });

  final PatientTimer patientTimer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveDesign.getScreenWidth() / 10,
        right: ResponsiveDesign.getScreenWidth() / 10,
      ),
      child: Container(
        width: ResponsiveDesign.getScreenWidth(),
        height: ResponsiveDesign.getScreenHeight() / 25,
        child: Center(
          child: _InfoTextDesign(
              text:
                  "Sensor Timer : ${PatientTimerUtils.getReadableFormat(patientTimer)}"),
        ),
      ),
    );
  }
}

class _InfoTextDesign extends StatelessWidget {
  final String text;

  _InfoTextDesign({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: ResponsiveDesign.getScreenWidth() / 20,
            // color: ProductColor.white,
            fontWeight: FontWeight.bold));
  }
}

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please Wait",
            style: TextStyle(
                fontSize: ResponsiveDesign.getScreenWidth() / 12,
                color: ProductColor.white),
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
