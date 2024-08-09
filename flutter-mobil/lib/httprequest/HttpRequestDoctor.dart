import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:blood_check/business/factory/UserFactory.dart';
import '../model/specialitem/doctor/PatientTimer.dart';
import '../model/user/Doctor.dart';
import '../model/user/Patient.dart';
import '../util/HttpUtil.dart';
import 'BaseHttpRequest.dart';
import 'ResponseEntity.dart';

class HttpRequestDoctor {
  static const String _classUrl = "/doctors";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  static Future<List<Patient>> getPatientListOfDoctorId(int id) async {
    Uri url = Uri.parse("$_baseUrl/$id/patients");
    log.i("URL : $url");
    var resp = await http.get(url);

    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Patient> patientList = UserFactory.createPatientList(respEntity.data);
    return patientList;
  }

  static Future<List<Doctor>> getDoctorList() async {
    Uri url = Uri.parse(_baseUrl);
    log.i("URL : $url");
    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Doctor> doctorList = UserFactory.createDoctorList(respEntity.data);
    return doctorList;
  }

  Future<http.Response> signUp(Doctor user) async {
    Uri url = Uri.parse("$_baseUrl");
    log.i("URL : $url");
    Map<String, dynamic> requestData = user.toJson();
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }

  static Future<http.Response> savePatientTimer(
      PatientTimer patientTimer) async {
    Uri url = Uri.parse("${BaseHttpRequestConfig.baseUrl}/timers");
    log.i("URL : ${url}");
    Map<String, dynamic> requestData = {
      "hours": patientTimer.hours,
      "minutes": patientTimer.minutes,
      "patientId": patientTimer.patientId,
    };
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }

  static Future<Doctor> findById(int id) async {
    Uri url = Uri.parse("$_baseUrl/$id");
    log.i("URL : $url");

    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    return UserFactory.createDoctor(respEntity.data);
  }

  Future<ResponseEntity> update(Doctor doctor) async {
    Uri url = Uri.parse("$_baseUrl");
    log.i("URL : $url");
    Map<String, dynamic> requestData = doctor.toJson();
    var resp = await http.put(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));

    Map<String, dynamic> jsonData = json.decode(resp.body);
    ResponseEntity respEntity = ResponseEntity.fromJson(jsonData);
    return respEntity;
  }
}
