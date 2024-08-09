import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'ProductColor.dart';

class AppBarUtil {
  static AppBar getAppBar() {
    return AppBar(
      backgroundColor: ProductColor.appBarBackgroundColor,
      foregroundColor: ProductColor.appBarForegroundColor,
      title: BlocBuilder<AppBarCubit, Widget>(builder: (builder, titleWidget) {
        return titleWidget;
      }),
    );
  }
}
