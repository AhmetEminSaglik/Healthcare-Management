import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

//https://www.udemy.com/course/flutter-ile-uygulama-gelistirme-kursu-android-ios/learn/lecture/23728946#overview
// to delete all comment  lines --> ctrl + f -->//.* --> delete all comments
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var log = Logger(printer: PrettyPrinter(colors: false));
  var flp = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    var androidSetup =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosSetup = const DarwinInitializationSettings();
    var instalationSetup =
        InitializationSettings(android: androidSetup, iOS: iosSetup);
    await flp.initialize(instalationSetup,
        onDidReceiveNotificationResponse: selectNotification);
  }

  Future<void> selectNotification(
      NotificationResponse notificationResponse) async {
    var payload = notificationResponse.payload;
    if (payload != null) {
      log.i("Notification is selected $payload");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  Future<void> showNotification() async {
    var androidNotificationDetail = const AndroidNotificationDetails(
        ("channel Id"), "channel Name",
        channelDescription: "Demo channel description",
        priority: Priority.high,
        importance: Importance.max);

    var iosNotificationDetail = const DarwinNotificationDetails();
    var notificationDetail = NotificationDetails(
        android: androidNotificationDetail, iOS: iosNotificationDetail);

    await flp.show(0, "Harpia Sağlık Analizi",
        "Çalışmalara Tam Gaz Devam Bulut Hocam.", notificationDetail,
        payload: "Payload Content");
  }

  Future<void> showDelayedNotification() async {
    var androidNotificationDetail = const AndroidNotificationDetails(
      "channel Id", "channel Name",
      channelDescription: "Demo channel description",
      priority: Priority.high,
      importance: Importance.max,
      // ticker: "ticker"
    );

    var iosNotificationDetail = const DarwinNotificationDetails();
    var notificationDetail = NotificationDetails(
        android: androidNotificationDetail, iOS: iosNotificationDetail);

    tz.initializeTimeZones();
    var delayed = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
    await flp.zonedSchedule(
        0, "Delayed Title", "Delayed  Content", delayed, notificationDetail,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: "Delayed Payload Context");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  showNotification();
                },
                child: const Text("Create Notification")),
            ElevatedButton(
                onPressed: () {
                  showDelayedNotification();
                },
                child: const Text("Create Notification-LATE")),
          ],
        ),
      ),
    );
  }
}
