import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';

class ListViewUtilItemColor {
  static Color getBackgroundColor({required int index}) {
    return index % 2 == 0 ? ProductColor.white : ProductColor.darkWhite;
  }
}

class ButtonItemColor {
  static Color getTextColor({required int index}) {
    return index % 2 == 0 ? ProductColor.white : ProductColor.bodyBackground;
  }

  static Color getBackgroundColor({required int index}) {
    return index % 2 == 0 ? ProductColor.pink : ProductColor.black;
  }
}
