import 'package:blood_check/model/userrole/EnumUserRole.dart';
import 'package:blood_check/util/SharedPrefUtils.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  List<StatefulWidget> drawerList = [];

  MainDrawer({super.key, required this.drawerList});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  int userRoleId = SharedPrefUtils.getRoleId();

  Widget getUserDrawer() {
    if (userRoleId == EnumUserRole.ADMIN.roleId) {
      return widget.drawerList[0];
    } else if (userRoleId == EnumUserRole.DOCTOR.roleId) {
      return widget.drawerList[1];
    } else if (userRoleId == EnumUserRole.PATIENT.roleId) {
      return widget.drawerList[2];
    }
    return const Text("Unknow UserRoleType");
  }

  @override
  Widget build(BuildContext context) {
    return getUserDrawer();
  }
}
