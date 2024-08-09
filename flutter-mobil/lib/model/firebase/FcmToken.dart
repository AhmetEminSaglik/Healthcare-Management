class FcmToken {
  late int _id;
  late int _userId;
  late String _token;

  FcmToken({required userId, required token}) {
    _userId = userId;
    _token = token;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get userId => _userId;

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  set userId(int value) {
    _userId = value;
  }

  @override
  String toString() {
    return 'FcmToken{_id: $_id, _userId: $_userId, _token: $_token}';
  }
}
