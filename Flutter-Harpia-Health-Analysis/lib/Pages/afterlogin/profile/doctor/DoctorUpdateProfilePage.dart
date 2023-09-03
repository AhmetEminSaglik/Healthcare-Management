import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_harpia_health_analysis/util/AppBarUtil.dart';
import '../../../../business/factory/UserFactory.dart';
import '../../../../core/ResponsiveDesign.dart';
import '../../../../httprequest/HttpRequestDoctor.dart';
import '../../../../httprequest/ResponseEntity.dart';
import '../../../../model/user/Doctor.dart';
import '../../../../model/user/User.dart';
import '../../../../model/userrole/EnumUserRole.dart';
import '../../../../util/CustomAlertDialog.dart';
import '../../../../util/ProductColor.dart';
import 'dart:convert';

class DoctorUpdateProfilePage extends StatefulWidget {
  const DoctorUpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<DoctorUpdateProfilePage> createState() =>
      _DoctorUpdateProfilePageState();
}

class _DoctorUpdateProfilePageState extends State<DoctorUpdateProfilePage> {
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
      appBar: AppBarUtil.getAppBar(),
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
                    _FormInputTextField(
                        hintText: "Username",
                        controller: tfUsername,
                        obscure: false),
                    _FormInputTextField(
                        hintText: "Password",
                        controller: tfPassword,
                        obscure: true),
                    _FormInputTextField(
                        hintText: "Name", controller: tfName, obscure: false),
                    _FormInputTextField(
                        hintText: "Lastname",
                        controller: tfLastname,
                        obscure: false),
                    _FormInputTextField(
                        hintText: "Spelization",
                        controller: tfSpecialization,
                        obscure: false),
                    _FormInputTextField(
                        hintText: "Graduate",
                        controller: tfGraduate,
                        obscure: false),
                    _UpdateProfileButton(
                      formKey: formKey,
                      tfUsername: tfUsername,
                      tfPassword: tfPassword,
                      tfName: tfName,
                      tfLastname: tfLastname,
                      tfGraduate: tfGraduate,
                      tfSpecialization: tfSpecialization,
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

class _FormInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;

  const _FormInputTextField(
      {required this.controller,
      required this.hintText,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return _InputTextFieldPadding(
      widget: _InputTextFormField(
        hint: hintText,
        textEditController: controller,
        obscureText: obscure,
      ),
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

class _InputTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditController;
  final bool obscureText;

  const _InputTextFormField(
      {required this.hint,
      required this.textEditController,
      required this.obscureText});

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
        if (data!.isEmpty) {
          return "Please enter $hint";
        }
        if (data.length < _TextFieldInputLength.min) {
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

class _UpdateProfileButton extends StatelessWidget {
  final TextEditingController tfUsername,
      tfPassword,
      tfName,
      tfLastname,
      tfSpecialization,
      tfGraduate;
  GlobalKey<FormState> formKey;

  _UpdateProfileButton(
      {required this.formKey,
      required this.tfUsername,
      required this.tfPassword,
      required this.tfName,
      required this.tfLastname,
      required this.tfGraduate,
      required this.tfSpecialization}); //({super.key /*,required this.screenInfo*/});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveDesign.getScreenWidth() / 1.5,
        height: ResponsiveDesign.getScreenHeight() / 15,
        child: ElevatedButton(
            onPressed: () {
              _updateProfileProcess(context);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.pink),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white)),
            child: Text("Update Profile",
                style: TextStyle(
                    fontSize: ResponsiveDesign.getScreenWidth() / 20))));
  }

  void resetTextFields(List<TextEditingController> list) {
    list.forEach((e) => e.text = "");
  }

  void _updateProfileProcess(BuildContext context) async {
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
        graduate: graduate,
      );
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

class _TextFieldInputLength {
  static int min = 3;
  static int max = 10;
}
