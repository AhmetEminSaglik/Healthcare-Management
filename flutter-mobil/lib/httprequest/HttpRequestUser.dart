import 'dart:convert';

import 'package:blood_check/httprequest/BaseHttpRequest.dart';
import 'package:blood_check/util/HttpUtil.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class HttpRequestUser {
  static const String _classUrl = "/users";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  Future<http.Response> login(String username, String password) async {
    Uri url = Uri.parse("$_baseUrl/login");
    log.i("URL : $url");
    Map<String, dynamic> requestData = {
      "username": username,
      "password": password,
    };
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }
}
