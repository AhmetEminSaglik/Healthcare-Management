import 'package:blood_check/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:blood_check/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:blood_check/Pages/afterlogin/homepage/users/doctor/HomePageDoctor.dart';
import 'package:blood_check/Pages/afterlogin/profile/doctor/DoctorProfile.dart';
import 'package:blood_check/util/SafeLogoutDrawerItem.dart';
import 'package:blood_check/util/SharedPrefUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class DoctorDrawer extends StatefulWidget {
  @override
  State<DoctorDrawer> createState() => _DoctorDrawerState();
}

class _DoctorDrawerState extends State<DoctorDrawer> {
  late int doctorId = SharedPrefUtils.getUserId();
  static var log = Logger(printer: PrettyPrinter(colors: false));

  @override
  void initState() {
    super.initState();
  }

  late var pageList = [
    HomePageDoctor(doctorId: doctorId),
    DoctorProfile(doctorId: doctorId)
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("DOCTOR Drawer Header")),
          _buildDrawerListTile(
              context: context, title: "HomePage", selectedIndex: 0),
          _buildDrawerListTile(
              context: context, title: "Profile", selectedIndex: 1),
          SafeLogoutDrawerItem(),
        ],
      ),
    );
  }

  ListTile _buildDrawerListTile(
      {required BuildContext context,
      required String title,
      required int selectedIndex}) {
    return ListTile(
      title: Text(title),
      onTap: () {
        context.read<DrawerCubit>().updateBody(pageList[selectedIndex]);
        context.read<AppBarCubit>().setTitleRoleName();
        Navigator.pop(context);
      },
    );
  }
/*
  ListTile _buildDrawerListTileSafeLogout({
    required BuildContext context,
    required String title,
    required int selectedIndex,
  }) {
    return ListTile(
      title: Text(title),
      onTap: () {
        setState(() {
          Navigator.of(context).popUntil(
              (route) => route.isFirst); //removes all pages until first page.
        });
      },
    );
  }*/
}
