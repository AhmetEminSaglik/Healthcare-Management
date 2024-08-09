import '../../model/firebase/FcmMessage.dart';

class FcmMessageFactory {
  static createFcmMessage(Map<String, dynamic> json) {
    return FcmMessage.fromJson(json);
  }
}
