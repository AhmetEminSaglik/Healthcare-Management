import 'package:flutter/material.dart';

import '../core/ResponsiveDesign.dart';
import '../util/ProductColor.dart';

class CustomButton extends StatelessWidget {
  final Function() action;
  final String text;
  Color backgroundColor = ProductColor.white;

  Color textColor = ProductColor.bodyBackgroundDark;
  double fontSize = ResponsiveDesign.getScreenHeight() / 40;

  CustomButton(
      {required this.action,
      required this.text,
      backgroundColor,
      fontSize,
      textColor}) {
    backgroundColor != null ? this.backgroundColor = backgroundColor : null;
    fontSize != null ? this.fontSize = fontSize : null;
    textColor != null ? this.textColor = textColor : null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 1.6,
      height: ResponsiveDesign.getScreenHeight() / 15,
      child: ElevatedButton(
        onPressed: action,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => backgroundColor),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
      ),
    );
  }
}
