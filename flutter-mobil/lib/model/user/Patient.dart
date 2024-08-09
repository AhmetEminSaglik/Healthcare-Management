import 'User.dart';

class Patient extends User {
  late int _diabeticTypeId;
  late int _doctorId;

  Patient(
      {required int id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      required String password,
      required int diabeticTypeId,
      required int doctorId})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password) {
    _diabeticTypeId = diabeticTypeId;
    _doctorId = doctorId;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json["id"],
        roleId: json["roleId"] as int,
        name: json["name"] as String,
        lastname: json["lastname"] as String,
        username: json["username"] as String,
        password: json["password"] as String,
        diabeticTypeId: json["diabeticTypeId"] as int,
        doctorId: json["doctorId"] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
      'diabeticTypeId': _diabeticTypeId,
      'doctorId': _doctorId,
    };
  }

  String toString() {
    return "Patient{" +
        "id=$id" +
        ", roleId=$roleId" +
        ", name='$name'" +
        ", lastname='$lastname'" +
        ", username='$username'" +
        ", password='$password'" +
        ", doctorId='$_doctorId'" +
        ", diabeticTypeId='$_diabeticTypeId'" +
        '}';
  }

  int get doctorId => _doctorId;

  set doctorId(int value) {
    _doctorId = value;
  }

  int get diabeticTypeId => _diabeticTypeId;

  set diabeticTypeId(int value) {
    _diabeticTypeId = value;
  }
}
