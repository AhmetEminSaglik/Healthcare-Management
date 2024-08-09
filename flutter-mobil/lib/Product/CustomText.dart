import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';

/*class CustomSingleText extends StatelessWidget {
  late String text;
  double fontSize = ResponsiveDesign.getScreenHeight() / 40;
  Color textColor = ProductColor.bodyBackgroundDark;
  Color backgroundColor = ProductColor.white;

  CustomSingleText({required this.text, textColor, backgroundColor, fontSize}) {
    text != null ? this.text = text : null;
    fontSize != null ? this.fontSize = fontSize : null;
    backgroundColor != null ? this.backgroundColor = backgroundColor : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ResponsiveDesign.getScreenHeight() / 18,
        width: ResponsiveDesign.getScreenWidth(),
        decoration: BoxDecoration(
            color: backgroundColor,
            // border: Border.all(color: Colors.red, width: 2.5),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding:
          EdgeInsets.only(left: ResponsiveDesign.getScreenWidth() / 15),
          child: Center(
            child: _DesignedText(
              isCenter: true,
              text: text,
              maxWidth: ResponsiveDesign.getScreenWidth(),
              fontSize: fontSize,
              textColor: textColor,
            ),
          ),
        ));
  }
}*/

class CustomText extends StatelessWidget {
  final String text1;
  final String text2;
  Color textColor = ProductColor.white;
  Color backgroundColor = ProductColor.bodyBackgroundDark;

  // Color textColor = ProductColor.bodyBackgroundDark;
  // Color backgroundColor = ProductColor.white;
  double fontSize = ResponsiveDesign.getScreenHeight() / 40;

  CustomText(
      {super.key,
      required this.text1,
      required this.text2,
      textColor,
      fontSize,
      backgroundColor}) {
    // textColor != null ? this.textColor = textColor : null;

    // text1 != null ? this.text1 = text1 : null;
    // text2 != null ? this.text2 = text2 : null;
    fontSize != null ? this.fontSize = fontSize : null;
    backgroundColor != null ? this.backgroundColor = backgroundColor : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ResponsiveDesign.getScreenHeight() / 18,
        decoration: BoxDecoration(
            color: backgroundColor,
            // border: Border.all(color: Colors.red, width: 2.5),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding:
              EdgeInsets.only(left: ResponsiveDesign.getScreenWidth() / 15),
          child: Row(
            children: [
              _DesignedText(
                text: text1,
                maxWidth: ResponsiveDesign.getScreenWidth() / 3,
                fontSize: fontSize,
                textColor: textColor,
              ),
              _DesignedText(
                text: ":",
                maxWidth: ResponsiveDesign.getScreenWidth() / 25,
                fontSize: fontSize,
                textColor: textColor,
              ),
              _DesignedText(
                text: text2,
                maxWidth: ResponsiveDesign.getScreenWidth() / 2.5,
                fontSize: fontSize,
                textColor: textColor,
              ),
            ],
          ),
        ));
  }
}

class _DesignedText extends StatelessWidget {
  final String text;
  double maxWidth = ResponsiveDesign.getScreenWidth() / 2;
  final double fontSize;
  final Color textColor;

  _DesignedText(
      {required this.text,
      maxWidth,
      required this.fontSize,
      required this.textColor}) {
    maxWidth != null ? this.maxWidth = maxWidth : null;
  }

/*
  Widget getText() {
    if (isCenter) {
      return Center(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(fontSize: fontSize, color: textColor),
      );
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }
}
