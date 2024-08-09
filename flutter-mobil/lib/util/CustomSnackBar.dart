import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static SnackBar getSnackBar(String msg) {
    return SnackBar(
      content: Text(
        msg,
        style: TextStyle(
            color: ProductColor.white,
            fontSize: ResponsiveDesign.getScreenWidth() / 27),
      ),
      closeIconColor: ProductColor.white,
      showCloseIcon: true,
      backgroundColor: ProductColor.black,
      duration: Duration(seconds: 5),
    );
  }
}
