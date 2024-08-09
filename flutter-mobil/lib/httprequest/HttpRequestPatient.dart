import 'dart:convert';

import 'package:blood_check/httprequest/BaseHttpRequest.dart';
import 'package:blood_check/model/specialitem/doctor/PatientTimer.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:blood_check/business/factory/UserFactory.dart';
import '../model/user/Doctor.dart';
import '../model/user/Patient.dart';
import '../util/HttpUtil.dart';
import 'ResponseEntity.dart';

class HttpRequestPatient {
  static var log = Logger(printer: PrettyPrinter(colors: false));

  static const String _classUrl = "/patients";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  static Future<List<Patient>> getPatientList() async {
    Uri url = Uri.parse(_baseUrl);
    log.i("URL : $url");
    var resp = await http.get(url);
    log.i(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Patient> patientList = UserFactory.createPatientList(respEntity.data);
    return patientList;
  }

  Future<http.Response> signUp(Patient user) async {
    Uri url = Uri.parse(_baseUrl);
    log.i("URL : $url");
    Map<String, dynamic> requestData = user.toJson();
    log.i("to json  $requestData");
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }

  static Future<PatientTimer> retrievePatientTimer(int patientId) async {
    Uri url = Uri.parse(
        "${BaseHttpRequestConfig.baseUrl}/timers$_classUrl/$patientId");
    log.i("URL : $url");
    var resp = await http.get(url);
    log.i(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    PatientTimer patientTimer = PatientTimer.fromJson(respEntity.data);
    return patientTimer;
  }

  static Future<Doctor> findResponsibleDoctorByPatientId(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/$patientId/doctors");
    log.i("URL : $url");
    var resp = await http.get(url);
    log.i(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    log.i("respEntity.data : ${respEntity}");
    return UserFactory.createDoctor(respEntity.data);
  }

  static Future<Patient> findPatientById(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/$patientId");
    log.i("URL : $url");
    var resp = await http.get(url);
    log.i(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    return UserFactory.createPatient(respEntity.data);
  }

  Future<ResponseEntity> update(Patient patient) async {
    Uri url = Uri.parse("$_baseUrl");
    log.i("URL : $url");
    Map<String, dynamic> requestData = patient.toJson();
    var resp = await http.put(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));

    Map<String, dynamic> jsonData = json.decode(resp.body);
    ResponseEntity respEntity = ResponseEntity.fromJson(jsonData);
    return respEntity;
  }
}
