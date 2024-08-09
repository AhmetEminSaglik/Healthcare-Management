import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:blood_check/business/factory/BloodResultFactory.dart';
import '../model/bloodresult/BloodResult.dart';
import '../model/user/Patient.dart';
import '../util/HttpUtil.dart';
import 'BaseHttpRequest.dart';
import 'ResponseEntity.dart';

class HttpRequestBloodResult {
  static const String _classUrl = "/bloodresults";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  static Future<List<BloodResult>> _sendBloodResultRequestToUrl(Uri url) async {
    log.i("URL : $url");
    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<BloodResult> bloodResultList =
        BloodResultFactory.createBloodResultList(respEntity.data);
    return bloodResultList;
  }

  static Future<List<BloodResult>> getDailyBloodResult(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/patient/$patientId/daily");
    return _sendBloodResultRequestToUrl(url);
  }

  static Future<List<BloodResult>> getWeeklyBloodResult(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/patient/$patientId/weekly");
    return _sendBloodResultRequestToUrl(url);
  }

  static Future<List<BloodResult>> getMonthlyBloodResult(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/patient/$patientId/monthly");
    return _sendBloodResultRequestToUrl(url);
  }

  Future<http.Response> signUp(Patient user) async {
    Uri url = Uri.parse(_baseUrl);
    log.i("URL : $url");
    Map<String, dynamic> requestData = user.toJson();
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }
}
