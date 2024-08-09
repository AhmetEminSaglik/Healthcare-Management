import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../core/ResponsiveDesign.dart';
import '../util/ProductColor.dart';

var log = Logger(printer: PrettyPrinter(colors: false));

class FormInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  bool compulsoryArea;

  FormInputTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscure,
      this.compulsoryArea = true});

  @override
  Widget build(BuildContext context) {
    return _InputTextFieldPadding(
      widget: _InputTextFormField(
        hint: hintText,
        textEditController: controller,
        obscureText: obscure,
        compulsoryArea: compulsoryArea,
      ),
    );
  }
}

class _InputTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditController;
  final bool obscureText;
  bool compulsoryArea;

  _InputTextFormField(
      {required this.hint,
      required this.textEditController,
      required this.obscureText,
      required this.compulsoryArea});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9]'))
      ],
      maxLength: _TextFieldInputLength.max,
      controller: textEditController,
      obscureText: obscureText,
      validator: (data) {
        if (data!.isEmpty && compulsoryArea) {
          log.i("data!.isEmpty : ${data!.isEmpty}");
          log.i("compulsoryArea : $compulsoryArea");
          return "Please enter $hint";
        }
        if (data.isNotEmpty) {
          compulsoryArea = true;
        }
        if (data.length < _TextFieldInputLength.min && compulsoryArea) {
          return "Please enter ${_TextFieldInputLength.min} or more  character";
        }
        if (data.length > _TextFieldInputLength.max) {
          return "Please enter ${_TextFieldInputLength.max} or less  character";
        }
        // return null;
      },
      decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(
              fontSize: ResponsiveDesign.getScreenWidth() / 23,
              color: ProductColor.black,
              fontWeight: FontWeight.bold),
          hintText: hint,
          hintStyle:
              TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 20),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: ProductColor.darkBlue)),
          filled: true,
          fillColor: ProductColor.white,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      style: TextStyle(
          fontSize: ResponsiveDesign.getScreenWidth() / 22,
          color: ProductColor.darkBlue),
    );
  }
}

class _InputTextFieldPadding extends StatelessWidget {
  final StatelessWidget widget;

  const _InputTextFieldPadding({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ResponsiveDesign.getScreenWidth() / 30,
          right: ResponsiveDesign.getScreenWidth() / 30,
          top: ResponsiveDesign.getScreenWidth() / 30,
          bottom: ResponsiveDesign.getScreenWidth() / 25),
      child: widget,
    );
  }
}

class _TextFieldInputLength {
  static int min = 3;
  static int max = 10;
}
