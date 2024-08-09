import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class CustomNotificationUtil {
  static var log = Logger(printer: PrettyPrinter(colors: false));

  static var _flp = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    var androidSetup =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosSetup = const DarwinInitializationSettings();
    var instalationSetup =
        InitializationSettings(android: androidSetup, iOS: iosSetup);
    await _flp.initialize(instalationSetup,
        onDidReceiveNotificationResponse: _selectNotification);
  }

  static Future<void> _selectNotification(
      NotificationResponse notificationResponse) async {
    var payload = notificationResponse.payload;
    if (payload != null) {
      log.i("Notification is selected $payload");
    }
  }

  static Future<void> showNotification(String title, String msg) async {
    var androidNotificationDetail = AndroidNotificationDetails(
        ("channel Id"), "channel Name",
        channelDescription: "Demo channel description",
        priority: Priority.high,
        importance: Importance.max,
        color: ProductColor.redAccent,
        styleInformation: const DefaultStyleInformation(true, true));
    var iosNotificationDetail = const DarwinNotificationDetails();
    var notificationDetail = NotificationDetails(
        android: androidNotificationDetail, iOS: iosNotificationDetail);
    await _flp.show(0, title, msg, notificationDetail,
        payload: "Burayi ANLAMADIM ???");
  }
}
