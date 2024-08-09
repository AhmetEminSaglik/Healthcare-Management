import 'User.dart';

class Doctor extends User {
  late String _specialization;
  late String _graduate;

  Doctor(
      {required int id,
      required int roleId,
      required String username,
      required String password,
      String name = "",
      String lastname = "",
      String specialization = "",
      String graduate = ""})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password) {
    this._specialization = specialization;
    this._graduate = graduate;
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["id"] as int,
      roleId: json["roleId"] as int,
      name: json["name"] as String,
      lastname: json["lastname"] as String,
      username: json["username"] as String,
      password: json["password"] as String,
      specialization: json["specialization"] as String,
      graduate: json["graduate"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
      'specialization': _specialization,
      'graduate': _graduate,
    };
  }

  String toString() {
    return "Doctor{" +
        "id=$id" +
        ", roleId=$roleId" +
        ", name=$name" +
        ", lastname=$lastname" +
        ", username=$username" +
        ", password=$password" +
        ", specialization=$_specialization" +
        ", graduate=$_graduate" +
        '}';
  }

  String get graduate => _graduate;

  String get specialization => _specialization;
}
