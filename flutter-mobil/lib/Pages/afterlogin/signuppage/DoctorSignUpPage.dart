import 'dart:convert';

import 'package:blood_check/Product/CustomButton.dart';
import 'package:blood_check/Product/FormCustomInput.dart';
import 'package:blood_check/business/factory/UserFactory.dart';
import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/httprequest/HttpRequestDoctor.dart';
import 'package:blood_check/httprequest/ResponseEntity.dart';
import 'package:blood_check/model/user/Doctor.dart';
import 'package:blood_check/model/user/User.dart';
import 'package:blood_check/model/userrole/EnumUserRole.dart';
import 'package:blood_check/util/CustomAlertDialog.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';


class DoctorSignUpPage extends StatefulWidget {
  const DoctorSignUpPage({Key? key}) : super(key: key);

  @override
  State<DoctorSignUpPage> createState() => _DoctorSignUpPageState();
}

class _DoctorSignUpPageState extends State<DoctorSignUpPage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfLastname = TextEditingController();
  TextEditingController tfSpecialization = TextEditingController();
  TextEditingController tfGraduate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProductColor.bodyBackground,
      body: Padding(
        padding: EdgeInsets.only(
            left: ResponsiveDesign.getScreenWidth() / 25,
            right: ResponsiveDesign.getScreenWidth() / 25,
            top: ResponsiveDesign.getScreenWidth() / 10,
            bottom: ResponsiveDesign.getScreenWidth() / 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    FormInputTextField(
                        hintText: "Username",
                        controller: tfUsername,
                        obscure: false,
                        compulsoryArea: true),
                    FormInputTextField(
                        hintText: "Password",
                        controller: tfPassword,
                        obscure: true,
                        compulsoryArea: true),
                    FormInputTextField(
                      hintText: "Name",
                      controller: tfName,
                      obscure: false,
                    ),
                    FormInputTextField(
                        hintText: "Lastname",
                        controller: tfLastname,
                        obscure: false),
                    FormInputTextField(
                        hintText: "Specialization",
                        controller: tfSpecialization,
                        obscure: false,
                        compulsoryArea: false),
                    FormInputTextField(
                        hintText: "Graduate",
                        controller: tfGraduate,
                        obscure: false,
                        compulsoryArea: false),
                    _SignUpButton(
                      formKey: formKey,
                      tfUsername: tfUsername,
                      tfPassword: tfPassword,
                      tfName: tfName,
                      tfLastname: tfLastname,
                      tfSpecialization: tfSpecialization,
                      tfGraduate: tfGraduate,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  final TextEditingController tfUsername,
      tfPassword,
      tfName,
      tfLastname,
      tfSpecialization,
      tfGraduate;
  GlobalKey<FormState> formKey;

  _SignUpButton(
      {required this.formKey,
      required this.tfUsername,
      required this.tfPassword,
      required this.tfName,
      required this.tfLastname,
      required this.tfSpecialization,
      required this.tfGraduate}); //({super.key /*,required this.screenInfo*/});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveDesign.getScreenWidth() / 1.5,
        height: ResponsiveDesign.getScreenHeight() / 15,
        child: CustomButton(
            action: () {
              _signUpProcess(context);
            },
            text: "Sign Up",
            textColor: ProductColor.white,
            backgroundColor: ProductColor.pink));
  }

  void resetTextFields(List<TextEditingController> list) {
    list.forEach((e) => e.text = "");
  }

  void _signUpProcess(BuildContext context) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      String username = tfUsername.text;
      String pass = tfPassword.text;
      String name = tfName.text;
      String lastname = tfLastname.text;
      String specialization = tfSpecialization.text;
      String graduate = tfGraduate.text;
      var request = HttpRequestDoctor();
      Doctor doctor = Doctor(
          id: 0,
          roleId: EnumUserRole.DOCTOR.roleId,
          name: name,
          lastname: lastname,
          username: username,
          password: pass,
          specialization: specialization,
          graduate: graduate);
      request.signUp(doctor).then((resp) async {
        Map<String, dynamic> jsonData = json.decode(resp.body);

        var respEntity = ResponseEntity.fromJson(jsonData);
        if (!respEntity.success) {
          showAlertDialogInvalidUsername(
              context: context, msg: respEntity.message);
        } else {
          User user = UserFactory.createUser(respEntity.data);
          showAlertDialogDoctorSignUpSuccessfully(
              context: context, msg: respEntity.message);
          List<TextEditingController> list = [
            tfUsername,
            tfPassword,
            tfName,
            tfLastname
          ];
          resetTextFields(list);
        }
      });
    }
  }

  void showAlertDialogInvalidUsername(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogUserSignUp(
            success: false,
            context: context,
            title: "Sign-Up",
            subTitle: "Failed :",
            msg: msg,
            roleId: EnumUserRole.DOCTOR.roleId));
  }

  void showAlertDialogDoctorSignUpSuccessfully(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogUserSignUp(
            success: true,
            context: context,
            title: "Sign-Up",
            subTitle: "Successfull",
            msg: msg,
            roleId: EnumUserRole.DOCTOR.roleId));
  }
}
