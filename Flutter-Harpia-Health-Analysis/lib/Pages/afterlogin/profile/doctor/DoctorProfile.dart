import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/doctor/DoctorUpdateProfilePage.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';

import '../../../../model/user/Doctor.dart';
import '../../../../util/ProductColor.dart';
import 'DoctorUpdateProfilePage2.dart';

class DoctorProfile extends StatefulWidget {
  int doctorId;

  DoctorProfile({required this.doctorId});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late Doctor doctor;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveDoctorData();
  }

  @override
  Widget build(BuildContext context) {
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
                  _ProfileItem(
                    labelName: "Name",
                    labelValue: doctor.name,
                  ),
                  _ProfileItem(
                    labelName: "LastName",
                    labelValue: doctor.lastname,
                  ),
                  _ProfileItem(
                    labelName: "Username",
                    labelValue: doctor.username,
                  ),
                  _ProfileItem(
                    labelName: "Specialization",
                    labelValue: doctor.specialization,
                  ),
                  _ProfileItem(
                    labelName: "Graduate",
                    labelValue: doctor.graduate,
                  ),
                  const _UpdateProfileButton(),
                ],
              ),
            ),
    );
  }

  retrieveDoctorData() async {
    doctor = await HttpRequestDoctor.findById(widget.doctorId);
    setState(() {
      isLoading = false;
    });
  }
}

class _ProfileItem extends StatelessWidget {
  final String labelName;
  final String labelValue;
  final Color labelNameColor = ProductColor.black;
  final Color labelValueColor = ProductColor.black;
  final double fontSize = ResponsiveDesign.getCertainHeight() / 40;

  _ProfileItem({required this.labelName, required this.labelValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveDesign.getScreenHeight() / 100),
      child: Row(
        children: [
          _ProfileItemDesignedText(
              color: labelNameColor, text: "$labelName : ", fontSize: fontSize),
          _ProfileItemDesignedText(
              color: labelValueColor, text: labelValue, fontSize: fontSize),
        ],
      ),
    );
  }
}

class _ProfileItemDesignedText extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;

  _ProfileItemDesignedText(
      {required this.color, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}

class _UpdateProfileButton extends StatelessWidget {
  const _UpdateProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DoctorUpdateProfilePage2()));
        },
        child: Text("Update Profile"));
  }
}
