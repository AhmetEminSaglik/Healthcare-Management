import 'package:auto_orientation/auto_orientation.dart';
import 'package:bloodcheck/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:bloodcheck/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:bloodcheck/Pages/afterlogin/profile/ProfilUpdatedCubit.dart';
import 'package:bloodcheck/firebase_options.dart';
import 'package:bloodcheck/model/firebase/FcmNotificationCubit.dart';
import 'package:bloodcheck/util/FcmTokenUtils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/afterlogin/homepage/users/patient/DetailLineChartCubit.dart';
import 'Pages/login/LoginPage.dart';
import 'core/ResponsiveDesign.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmTokenUtils.createToken();
  AutoOrientation.portraitAutoMode();
  await FirebaseMessaging.instance.getInitialMessage();
  await FirebaseMessaging.instance.requestPermission();
  runApp(const MyApp());
}
/*
void test() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    print('--> Got a message whilst in the foreground!$message');
    print('----> Message predata: ${message.data}');

    // CustomNotification.showNotification(message.predata);
    // parseMapToString(message.predata);
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveDesign(mediaQueryData: MediaQuery.of(context));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DrawerCubit()),
        BlocProvider(create: (context) => AppBarCubit()),
        BlocProvider(create: (context) => FcmNotificationCubit()),
        BlocProvider(create: (context) => ProfilUpdatedCubit()),
        BlocProvider(create: (context) => DetailLineChartCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home:  HomePage(),
        home: LoginPage(title: "Login"),
      ),
    );
  }
}
