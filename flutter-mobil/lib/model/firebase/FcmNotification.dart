import 'package:logger/logger.dart';

class FcmNotification {
  static var log = Logger(printer: PrettyPrinter(colors: false));

  late String _title;
  late String _body;

  FcmNotification({required title, required body}) {
    _title = title;
    _body = body;
  }

  factory FcmNotification.fromJson(Map<String, dynamic> json) {
    log.i('gelen json : $json');
    return FcmNotification(
        title: json["title"] as String, body: json["body"] as String);
  }

  @override
  String toString() {
    return 'FcmNotification{_title: $_title, _body: $_body}';
  }

  String get body => _body;

  String get title => _title;
}
