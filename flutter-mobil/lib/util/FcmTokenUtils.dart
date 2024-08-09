import 'package:blood_check/business/factory/FcmMessageFactory.dart';
import 'package:blood_check/model/firebase/FcmData.dart';
import 'package:blood_check/model/firebase/FcmMessage.dart';
import 'package:blood_check/model/firebase/FcmNotificationCubit.dart';
import 'package:blood_check/model/firebase/enum/EnumFcmMessageReason.dart';
import 'package:blood_check/util/CustomNotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';


class FcmTokenUtils {
  static var log = Logger(printer: PrettyPrinter(colors: false));

  // static CustomLog log = CustomLog(className: "FcmTokenUtils");

  static late String _token;

  static Future<void> createToken() async {
    _token = (await FirebaseMessaging.instance.getToken())!;
  }

  static String getToken() {
    return _token;
  }

  static int? _viewPatientIdPage;

  static updatePatientId(int patientId) {
    _viewPatientIdPage = patientId;
  }

  static listenFcm(BuildContext context) {
    try {
      log.e("NOTIFICAITON ALINDI");
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        FcmData fcmData = parseMapToFcmData(message.data);

        processSendReason(context, fcmData);
        if (fcmData.showNotification) {
          CustomNotificationUtil.showNotification(
              fcmData.msgTitle, fcmData.msg);
        }
      });
    } catch (e) {
      // log.error(msgTitle: "FcmTokenUtils Exception", msg: "$e");
      // log.error("Exception Occurred $e");
    }
  }

  static void processSendReason(BuildContext context, FcmData fcmData) {
    int code = fcmData.reasonCode;
    if (code ==
        EnumFcmMessageReason.getCodeOfReason(
            EnumFcmMessageReason.UPDATE_LINE_CHART.name)) {
      updateLineChartInPatientPage(context, fcmData.patientId);
    }
    if (code ==
        EnumFcmMessageReason.getCodeOfReason(
            EnumFcmMessageReason.UPDATE_SENSOR_TIMER.name)) {
      updateSensorTimerInPatientPage(context, fcmData.patientId);
    }
  }

  static void updateLineChartInPatientPage(
      BuildContext context, int patientId) {
    if (_viewPatientIdPage == patientId) {
      context.read<FcmNotificationCubit>().enableUpdatingPatientLineChart();
    }
  }

  static void updateSensorTimerInPatientPage(
      BuildContext context, int patientId) {
    if (_viewPatientIdPage == patientId) {
      context.read<FcmNotificationCubit>().enableUpdateSensorTimer();
    }
  }

  static FcmData parseMapToFcmData(Map<String, dynamic> map) {
    // String data = "";
    /*for (var entry in map.entries) {
      log.info("entry.key : ${entry.key}");
      log.info("entry.value : ${entry.value}");
      data += entry.value;
    }
    log.info("DATA : $data ");
    log.info("map : $map ");*/
    FcmMessage message = FcmMessageFactory.createFcmMessage(map);
    return message.fcmData;
    /* log.info("FcmMessage : $message");
    CustomNotificationUtil.showNotification(
        message.fcmData.msgTitle, message.fcmData.msg);
    return data;*/
  }

  static listenBackground() {
    FirebaseMessaging.onBackgroundMessage((message) {
      return _backgroundHandler(message);
    });
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    // log.info('Got a message whilst in the background!');
    // log.info('Message predata: ${message.data}');

    if (message.notification != null) {
      // log.info(
      //     'Message also contained a notification: ${message.notification}');
      final title = message.notification?.title ?? "Title is Null";
      final body = message.notification?.body ?? "Body is Null";
      CustomNotificationUtil.showNotification(title, body);
    }
  }
}
