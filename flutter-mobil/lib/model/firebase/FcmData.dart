class FcmData {
  late String _msgTitle;
  late String _msg;
  late bool _showNotification;
  late int _patientId;
  late int _reasonCode;
  late String _reasonSend;

  FcmData({
    url = "",
    required msgTitle,
    required msg,
    required showNotification,
    required int patientId,
    required int reasonCode,
    required String reasonSend,
  }) {
    _msg = msg;
    _msgTitle = msgTitle;
    _showNotification = showNotification;
    _patientId = patientId;
    _reasonCode = reasonCode;
    _reasonSend = reasonSend;
  }

  factory FcmData.fromJson(Map<String, dynamic> json) {
    bool showNotification = bool.parse(json["showNotification"] as String);
    int patientId = int.parse(json["patientId"] as String);
    int reasonCode = int.parse(json["reasonCode"] as String);
    return FcmData(
      msgTitle: json["msgTitle"] as String,
      msg: json["msg"] as String,
      patientId: patientId,
      showNotification: showNotification,
      reasonCode: reasonCode,
      reasonSend: json["reasonSend"] as String,
    );
  }

  @override
  String toString() {
    return 'FcmData{_msgTitle: $_msgTitle, _msg: $_msg, _showNotification: $_showNotification, _patientId: $_patientId, _reasonCode: $_reasonCode, _reasonSend: $_reasonSend}';
  }

  String get msg => _msg;

  String get msgTitle => _msgTitle;

  bool get showNotification => _showNotification;

  int get patientId => _patientId;

  String get reasonSend => _reasonSend;

  int get reasonCode => _reasonCode;
}
