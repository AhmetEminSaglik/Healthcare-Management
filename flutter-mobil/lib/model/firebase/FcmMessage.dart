import 'FcmData.dart';

class FcmMessage {
  late FcmData _fcmData;

  FcmMessage({required fcmData}) {
    _fcmData = fcmData;
  }

  factory FcmMessage.fromJson(Map<String, dynamic> json) {
    return FcmMessage(fcmData: FcmData.fromJson(json));
  }

  @override
  String toString() {
    return 'FcmMessage{_fcmData: $_fcmData}';
  }

  FcmData get fcmData => _fcmData;
}
