import 'package:blood_check/model/userrole/EnumUserRole.dart';
import 'package:blood_check/util/SharedPrefUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBarCubit extends Cubit<Widget> {
  Widget appBarTitleWidget = const Text("Empty Text");
  var backgroundColor = Colors.green;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  AppBarCubit() : super(const Text("Empty Text"));

  void setTitle(Widget title) {
    appBarTitleWidget = AppBar(title: title);
    log.i('new title : $title');
    emit(appBarTitleWidget);
  }

  void setTitleRoleName() {
    int roleId = SharedPrefUtils.getRoleId();
    String roleName = EnumUserRole.getRoleName(roleId);
    appBarTitleWidget = Text("$roleName Page");
    emit(appBarTitleWidget);
  }

  void setTitleRoleNameWithPageListSize(int listSize) {
    int roleId = SharedPrefUtils.getRoleId();
    String roleName = EnumUserRole.getRoleName(roleId);
    appBarTitleWidget = Row(
        children: [Text("$roleName Page"), const Spacer(), Text("$listSize")]);
    emit(appBarTitleWidget);
  }
}
