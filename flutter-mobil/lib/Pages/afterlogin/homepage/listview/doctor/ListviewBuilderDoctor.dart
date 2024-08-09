import 'package:blood_check/Pages/afterlogin/homepage/users/doctor/HomePageDoctor.dart';
import 'package:blood_check/core/ResponsiveDesign.dart';
import 'package:blood_check/httprequest/HttpRequestDoctor.dart';
import 'package:blood_check/model/user/Doctor.dart';
import 'package:blood_check/util/IndexColorUtil.dart';
import 'package:blood_check/util/ProductColor.dart';
import 'package:flutter/material.dart';

class ListviewBuilderDoctor extends StatefulWidget {
  @override
  State<ListviewBuilderDoctor> createState() => _ListviewBuilderDoctorState();
}

class _ListviewBuilderDoctorState extends State<ListviewBuilderDoctor> {
  bool isLoading = true;
  List<Doctor> doctorList = [];

  @override
  void initState() {
    super.initState();
    retriveDoctorList();
  }

  void retriveDoctorList() async {
    isLoading = true;
    setState(() {});
    var resp = await HttpRequestDoctor.getDoctorList();
    setState(() {
      isLoading = false;
      doctorList = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ProductColor.bodyBackground,
        body: RefreshIndicator(
          onRefresh: () async {
            retriveDoctorList();
          },
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : getBodyDoctorListview(doctorList),
        ));
  }
}

Widget getBodyDoctorListview(List<Doctor> doctorList) {
  if (doctorList.isEmpty) {
    return Padding(
      padding: EdgeInsets.only(
          right: ResponsiveDesign.getScreenWidth() / 25,
          top: ResponsiveDesign.getScreenWidth() / 15,
          left: ResponsiveDesign.getScreenWidth() / 25),
      child: Text(
        "You dont have any patient yet.",
        style: TextStyle(
          fontSize: ResponsiveDesign.getScreenWidth() / 20,
        ),
      ),
    );
  } else {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveDesign.getScreenWidth() / 40,
        top: ResponsiveDesign.getScreenWidth() / 80,
        right: ResponsiveDesign.getScreenWidth() / 40,
      ),
      child: ListView.builder(
          itemCount: doctorList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                navigateToPatientChartPage(
                    context: context,
                    routePage: HomePageDoctor(doctorId: doctorList[index].id));
              },
              child: Card(
                color: ListViewUtilItemColor.getBackgroundColor(index: index),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Container(
                  height: ResponsiveDesign.getScreenHeight() / 11,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: ResponsiveDesign.getScreenWidth() / 25,
                        top: ResponsiveDesign.getScreenWidth() / 17,
                        right: ResponsiveDesign.getScreenWidth() / 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListViewItemText(
                              isBold: false,
                              text:
                                  "${"${doctorList[index].name} ${doctorList[index].lastname}"}"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ListViewItemText extends StatelessWidget {
  const ListViewItemText({super.key, required this.text, required this.isBold});

  final bool isBold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ResponsiveDesign.getScreenWidth() / 25),
      child: Text(
        text,
        style: TextStyle(
          fontSize: ResponsiveDesign.getScreenHeight() / 40,
          fontWeight: isBold ? FontWeight.bold : null,
        ),
      ),
    );
  }
}

void navigateToPatientChartPage(
    {required BuildContext context, required routePage}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => routePage));
}
