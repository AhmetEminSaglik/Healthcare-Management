class BaseHttpRequestConfig {
  static const String _localhost = "http://10.0.2.2:";
  // static const String _localhost = "http://192.168.1.36:";
  static const String _port = "8080";
  static const String _apiVersion = "/api/1.0";
  static const String _baseUrl = _localhost + _port + _apiVersion;

  static String get localhost => _localhost;

  static String get port => _port;

  static String get baseUrl => _baseUrl;

  static String get apiVersion => _apiVersion;
}
