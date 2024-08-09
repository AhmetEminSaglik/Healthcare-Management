import 'package:blood_check/Pages/afterlogin/profile/ProfilUpdatedCubit.dart';
import 'package:blood_check/Product/CustomButton.dart';
import 'package:blood_check/Product/CustomText.dart';
import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/httprequest/HttpRequestDoctor.dart';
import 'package:blood_check/model/user/Doctor.dart';
import 'package:blood_check/util/PermissionUtils.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'DoctorUpdateProfilePage.dart';

class DoctorProfile extends StatefulWidget {
  int doctorId;

  DoctorProfile({required this.doctorId});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late Doctor doctor;
  bool isLoading = true;
  final String unknowData = "Unknown Data";
  final double spaceHeight = ResponsiveDesign.getScreenHeight() / 40;

  renderPage() {
    return BlocBuilder<ProfilUpdatedCubit, bool>(
      builder: (builder, isUpdated) {
        if (isUpdated) {
          isLoading = isUpdated;
          retrieveData();
          context.read<ProfilUpdatedCubit>().setFalse();
        }
        return Container();
      },
    );
  }

  void updateProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DoctorUpdateProfilePage(doctor: doctor)));
  }

  @override
  Widget build(BuildContext context) {
    retrieveData();
    return Scaffold(
      backgroundColor: ProductColor.bodyBackground,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(
                left: ResponsiveDesign.getScreenWidth() / 20,
                right: ResponsiveDesign.getCertainWidth() / 20,
                top: ResponsiveDesign.getScreenHeight() / 40,
              ),
              child: Column(
                children: [
                  renderPage(),
                  PermissionUtils.letRunForDoctor()
                      ? Text(
                          "My Profile",
                          style: TextStyle(
                            fontSize: ResponsiveDesign.getScreenHeight() / 30,
                            color: ProductColor.black,
                          ),
                        )
                      : Container(),
                  _getProfileTitleForDoctor(),
                  SizedBox(height: spaceHeight),
                  PermissionUtils.letRunForDoctor()
                      ? CustomTextWithSizeBox(
                          space: spaceHeight,
                          text1: "Username",
                          text2: doctor.username.isNotEmpty
                              ? doctor.username
                              : unknowData,
                        )
                      : Container(),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Name",
                      text2: doctor.name.isNotEmpty ? doctor.name : unknowData),
                  CustomTextWithSizeBox(
                    space: spaceHeight,
                    text1: "Lastname",
                    text2: doctor.lastname.isNotEmpty
                        ? doctor.lastname
                        : unknowData,
                  ),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Specialization",
                      text2: doctor.specialization),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Graduate",
                      text2: doctor.graduate),
                  _getUpdateProfileButtonForDoctor(),
                ],
              ),
            ),
    );
  }

  Widget _getProfileTitleForDoctor() {
    if (PermissionUtils.letRunForPatient()) {
      return Text(
        "My Doctor Profile",
        style: TextStyle(
          fontSize: ResponsiveDesign.getScreenHeight() / 30,
          color: ProductColor.black,
        ),
      );
    }
    return Container();
  }

  Widget _getUpdateProfileButtonForDoctor() {
    if (PermissionUtils.letRunForDoctor()) {
      return CustomButton(
        action: () {
          updateProfile();
        },
        text: "Update Profile",
      );
    }
    return Container();
  }

  retrieveData() async {
    if (isLoading) {
      doctor = await HttpRequestDoctor.findById(widget.doctorId);
      setState(() {
        isLoading = false;
      });
    }
  }
}

class CustomTextWithSizeBox extends StatelessWidget {
  String text1 = "";
  String text2 = "";
  final double space;

  CustomTextWithSizeBox({text1, text2, required this.space}) {
    text1 != null ? this.text1 = text1 : null;
    text2 != null ? this.text2 = text2 : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(text1: text1, text2: text2),
        SizedBox(
          height: space,
        )
      ],
    );
  }
}
