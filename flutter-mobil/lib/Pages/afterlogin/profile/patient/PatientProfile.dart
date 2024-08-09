import 'package:blood_check/Pages/afterlogin/profile/ProfilUpdatedCubit.dart';
import 'package:blood_check/Product/CustomButton.dart';
import 'package:blood_check/Product/CustomText.dart';
import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/httprequest/HttpRequestPatient.dart';
import 'package:blood_check/model/enums/diabetic/EnumDiabeticType.dart';
import 'package:blood_check/model/user/Doctor.dart';
import 'package:blood_check/model/user/Patient.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PatientUpdateProfilePage.dart';

class PatientProfile extends StatefulWidget {
  int patientId;

  PatientProfile({required this.patientId});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  late Patient patient;
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
            builder: (context) => PatientUpdateProfilePage(
                  patient: patient,
                )));
  }

  @override
  Widget build(BuildContext context) {
    retrieveData();
    return Scaffold(
      backgroundColor: ProductColor.bodyBackground,
      body: SingleChildScrollView(
        child: isLoading
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
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: ResponsiveDesign.getScreenHeight() / 25),
                      child: Column(children: [
                        Text(
                          "My Profile",
                          style: TextStyle(
                            fontSize: ResponsiveDesign.getScreenHeight() / 30,
                            color: ProductColor.black,
                          ),
                        ),
                        SizedBox(height: spaceHeight),
                        CustomTextWithSizeBox(
                            space: spaceHeight,
                            text1: "Username",
                            text2: patient.username.isNotEmpty
                                ? patient.username
                                : unknowData),
                        CustomTextWithSizeBox(
                            space: spaceHeight,
                            text1: "Name",
                            text2: patient.name.isNotEmpty
                                ? patient.name
                                : unknowData),
                        CustomTextWithSizeBox(
                          space: spaceHeight,
                          text1: "Lastname",
                          text2: patient.lastname.isNotEmpty
                              ? patient.lastname
                              : unknowData,
                        ),
                        CustomTextWithSizeBox(
                            space: spaceHeight,
                            text1: "Doctor",
                            text2: doctor.lastname),
                        CustomTextWithSizeBox(
                            space: spaceHeight,
                            text1: "Diabetic Type",
                            text2: EnumDiabeticType.getTypeName(
                                patient.diabeticTypeId)),
                      ]),
                    ),
                    CustomButton(text: "Update Profile", action: updateProfile),
                  ],
                ),
              ),
      ),
    );
  }

  retrieveData() async {
    if (isLoading) {
      patient = await HttpRequestPatient.findPatientById(widget.patientId);
      doctor =
          await HttpRequestPatient.findResponsibleDoctorByPatientId(patient.id);
      setState(() {
        isLoading = false;
      });
    }
  }
}

class CustomTextWithSizeBox extends StatelessWidget {
  final String text1;
  final String text2;
  final double space;

  CustomTextWithSizeBox(
      {required this.text1, required this.text2, required this.space});

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
