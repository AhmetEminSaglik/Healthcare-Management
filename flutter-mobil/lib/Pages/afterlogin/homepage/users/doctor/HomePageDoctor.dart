import 'package:bloodcheck/Pages/afterlogin/homepage/listview/patient/ListviewBuilderPatient.dart';
import 'package:bloodcheck/util/AppBarUtil.dart';
import 'package:bloodcheck/util/PermissionUtils.dart';
import 'package:flutter/material.dart';

class HomePageDoctor extends StatefulWidget {
  final int doctorId;

  const HomePageDoctor({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<HomePageDoctor> createState() => _HomePageDoctorState();
}

class _HomePageDoctorState extends State<HomePageDoctor> {
  bool visibleAppBar = false;

  // List<Patient> patientList = [];
/*
  AppBar getAppBar() {
    return AppBar(
      backgroundColor: ProductColor.appBarBackgroundColor,
      title: BlocBuilder<AppBarCubit, Widget>(builder: (builder, titleWidget) {
        return titleWidget;
      }),
    );
  }*/

  @override
  void initState() {
    super.initState();
    visibleAppBar = PermissionUtils.letRunForAdmin();
    // setPatientList(widget.doctorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: visibleAppBar ? AppBarUtil.getAppBar() : null,
      body: ListviewBuilderPatient(widget.doctorId),
    );
  }

/*void setPatientList(int doctorId) async {
    patientList = await HttpRequestDoctor.getPatientListOfDoctorId(doctorId);
  }*/
}
