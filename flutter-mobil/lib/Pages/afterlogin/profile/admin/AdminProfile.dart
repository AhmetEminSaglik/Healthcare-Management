import 'package:blood_check/Pages/afterlogin/profile/ProfilUpdatedCubit.dart';
import 'package:blood_check/Product/CustomButton.dart';
import 'package:blood_check/Product/CustomText.dart';
import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/httprequest/HttpRequestAdmin.dart';
import 'package:blood_check/model/user/Admin.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AdminUpdateProfilePage.dart';

class AdminProfile extends StatefulWidget {
  int adminId;

  AdminProfile({required this.adminId});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  late Admin admin;
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
            builder: (context) => AdminUpdateProfilePage(admin: admin)));
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
                      text2: admin.username.isNotEmpty
                          ? admin.username
                          : unknowData),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Name",
                      text2: admin.name.isNotEmpty ? admin.name : unknowData),
                  CustomTextWithSizeBox(
                      space: spaceHeight,
                      text1: "Lastname",
                      text2: admin.lastname.isNotEmpty
                          ? admin.lastname
                          : unknowData),
                  CustomButton(text: "Update Profile", action: updateProfile),
                ],
              ),
            ),
    );
  }

  retrieveData() async {
    if (isLoading) {
      admin = await HttpRequestAdmin.findById(widget.adminId);
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
