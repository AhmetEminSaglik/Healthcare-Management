import 'package:blood_check/Pages/afterlogin/profile/ProfilUpdatedCubit.dart';
import 'package:blood_check/Pages/afterlogin/profile/doctor/DoctorProfile.dart';
import 'package:blood_check/Product/CustomButton.dart';
import 'package:blood_check/Product/FormCustomInput.dart';
import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/httprequest/HttpRequestDoctor.dart';
import 'package:blood_check/httprequest/ResponseEntity.dart';
import 'package:blood_check/model/user/Doctor.dart';
import 'package:blood_check/util/AppBarUtil.dart';
import 'package:blood_check/util/CustomSnackBar.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:blood_check/util/SharedPrefUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorUpdateProfilePage extends StatefulWidget {
  late Doctor doctor;

  DoctorUpdateProfilePage({required this.doctor});

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
                    FormInputTextField(
                      hintText: "Username",
                      controller: tfUsername,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Password",
                      controller: tfPassword,
                      obscure: true,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Name",
                      controller: tfName,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Lastname",
                      controller: tfLastname,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Spelization",
                      controller: tfSpecialization,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Graduate",
                      controller: tfGraduate,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    _UpdateProfileButton(
                      formKey: formKey,
                      defaultDoctor: widget.doctor,
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

class _UpdateProfileButton extends StatelessWidget {
  late Doctor defaultDoctor;
  List<TextEditingController> list = [];
  final TextEditingController tfUsername,
      tfPassword,
      tfName,
      tfLastname,
      tfSpecialization,
      tfGraduate;
  GlobalKey<FormState> formKey;

  _UpdateProfileButton(
      {required this.formKey,
      required this.defaultDoctor,
      required this.tfUsername,
      required this.tfPassword,
      required this.tfName,
      required this.tfLastname,
      required this.tfGraduate,
      required this.tfSpecialization}) {
    list.add(tfUsername);
    list.add(tfPassword);
    list.add(tfName);
    list.add(tfLastname);
    list.add(tfGraduate);
    list.add(tfSpecialization);
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      action: () {
        _updateProfileProcess(context);
      },
      text: "Update",
      textColor: ProductColor.white,
      backgroundColor: ProductColor.pink,
    );
  }

  void resetTextFields(List<TextEditingController> list) {
    list.forEach((e) => e.text = "");
  }

  bool isAnyAreaFilled() {
    if (tfUsername.text.isNotEmpty ||
        tfPassword.text.isNotEmpty ||
        tfName.text.isNotEmpty ||
        tfLastname.text.isNotEmpty ||
        tfSpecialization.text.isNotEmpty ||
        tfGraduate.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void _updateProfileProcess(BuildContext context) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      if (isAnyAreaFilled()) {
        String username = tfUsername.text;
        String password = tfPassword.text;
        String name = tfName.text;
        String lastname = tfLastname.text;
        String specialization = tfSpecialization.text;
        String graduate = tfGraduate.text;

        Doctor doctor = Doctor(
          id: defaultDoctor.id,
          roleId: defaultDoctor.roleId,
          name: name.isNotEmpty ? name : defaultDoctor.name,
          lastname: lastname.isNotEmpty ? lastname : defaultDoctor.lastname,
          username: username.isNotEmpty ? username : defaultDoctor.username,
          password: password.isNotEmpty ? password : defaultDoctor.password,
          specialization: specialization.isNotEmpty
              ? specialization
              : defaultDoctor.specialization,
          graduate: graduate.isNotEmpty ? graduate : defaultDoctor.graduate,
        );
        var request = HttpRequestDoctor();

        ResponseEntity? respEntity;

        await request.update(doctor).then((value) => respEntity = value);

        if (respEntity != null) {
          if (respEntity!.success) {
            context.read<ProfilUpdatedCubit>().setTrue();
            await SharedPrefUtils.setLoginDataUser(doctor).then((value) {});
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DoctorProfile(doctorId: (defaultDoctor.id))));
            String msg = "Updated Successfuly";
            ScaffoldMessenger.of(context)
                .showSnackBar(CustomSnackBar.getSnackBar(msg));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(CustomSnackBar.getSnackBar(respEntity!.message));
          }
        }
      } else {
        String msg = "Must be filled at least one area to update profile";
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar.getSnackBar(msg));
      }
    }
  }
}
