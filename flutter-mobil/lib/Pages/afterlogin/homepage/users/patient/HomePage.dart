import 'package:blood_check/Pages/afterlogin/homepage/drawer/AdminDrawer.dart';
import 'package:blood_check/Pages/afterlogin/homepage/drawer/DoctorDrawer.dart';
import 'package:blood_check/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:blood_check/Pages/afterlogin/homepage/drawer/MainDrawer.dart';
import 'package:blood_check/Pages/afterlogin/homepage/drawer/PatientDrawer.dart';
import 'package:blood_check/util/AppBarUtil.dart';
import 'package:blood_check/util/FcmTokenUtils.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:blood_check/util/SharedPrefUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

  const HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  static var log = Logger(printer: PrettyPrinter(colors: false));

  int userId = SharedPrefUtils.getUserId();
  late final MainDrawer mainDrawer;
  late final AdminDrawer _adminDrawer;
  late final DoctorDrawer _doctorDrawer;
  late final PatientDrawer _patientDrawer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableBackgroundExecution();
    prepareDrawer();
  }

  void prepareDrawer() {
    _adminDrawer = AdminDrawer();
    _doctorDrawer = DoctorDrawer();
    _patientDrawer = PatientDrawer(patientId: userId);
    mainDrawer =
        MainDrawer(drawerList: [_adminDrawer, _doctorDrawer, _patientDrawer]);
    log.i("Drawer's are prepared");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtil
          .getAppBar() /*AppBar(
        // backgroundColor: ProductColor.appBarBackgroundColor,
        title:
            BlocBuilder<AppBarCubit, Widget>(builder: (builder, titleWidget) {
          return titleWidget;
        }),
      )*/
      ,
      drawer: mainDrawer,
      backgroundColor: ProductColor.bodyBackground,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: BlocBuilder<DrawerCubit, Widget>(
              builder: (builder, drawerClickBody) {
                return drawerClickBody;
              },
            ),
          )
        ],
      ),
    );
  }
}

void enableBackgroundExecution() async {
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "flutter_background example app",
    notificationText:
        "Background notification for keeping the example app running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(
        name: 'background_icon',
        defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );
  bool success =
      await FlutterBackground.initialize(androidConfig: androidConfig);
  if (FlutterBackground.isBackgroundExecutionEnabled) {
    FcmTokenUtils.listenBackground();
  }
}

/*Future<void> requestPermission() async {
  // final PermissionStatus status = await Permission.foregroundService.request();
  if (status.isGranted) {
    // İzin verildi, arka planda çalışabilirsiniz.
  } else {
    // İzin verilmedi, kullanıcıya açıklama yapabilirsiniz.
  }
}*/
