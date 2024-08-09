import 'dart:convert';

import 'package:blood_check/business/factory/UserFactory.dart';
import 'package:blood_check/model/user/Admin.dart';
import 'package:blood_check/util/HttpUtil.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'BaseHttpRequest.dart';
import 'ResponseEntity.dart';

class HttpRequestAdmin {
  static const String _classUrl = "/admins";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  static Future<Admin> findById(int id) async {
    Uri url = Uri.parse("$_baseUrl/$id");
    log.i("URL : $url");

    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    return UserFactory.createAdmin(respEntity.data);
  }

  static Future<ResponseEntity> update(Admin admin) async {
    Uri url = Uri.parse(_baseUrl);
    log.i("URL : $url");
    Map<String, dynamic> requestData = admin.toJson();
    var resp = await http.put(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));

    Map<String, dynamic> jsonData = json.decode(resp.body);
    ResponseEntity respEntity = ResponseEntity.fromJson(jsonData);
    return respEntity;
  }
}
