import 'User.dart';

class Admin extends User {
  Admin(
      {required int id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      required String password})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password) {
    id = id;
    roleId = roleId;
    name = name;
    lastname = lastname;
    username = username;
    password = password;
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
        id: json["id"] as int,
        roleId: json["roleId"] as int,
        name: json["name"] as String,
        lastname: json['lastname'] as String,
        username: json["username"] as String,
        password: json["password"] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
    };
  }

  String toString() {
    return "Admin{" +
        "id=$id" +
        ", roleId=$roleId" +
        ", name='$name'" +
        ", lastname='$lastname'" +
        ", username='$username'" +
        ", password='$password'" +
        '}';
  }
}
