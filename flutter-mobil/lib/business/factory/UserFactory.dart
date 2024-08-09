import '../../model/user/Admin.dart';
import '../../model/user/Doctor.dart';
import '../../model/user/Patient.dart';
import '../../model/user/User.dart';

class UserFactory {
  static User createUser(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  static Admin createAdmin(Map<String, dynamic> json) {
    return Admin.fromJson(json);
  }

  static Doctor createDoctor(Map<String, dynamic> json) {
    return Doctor.fromJson(json);
  }

  static Patient createPatient(Map<String, dynamic> json) {
    return Patient.fromJson(json);
  }

  static List<User> createUserList(List<dynamic> json) {
    List<User> userList = json.map((data) => User.fromJson(data)).toList();
    return userList;
  }

  static List<Patient> createPatientList(List<dynamic> json) {
    List<Patient> patientList =
        json.map((data) => Patient.fromJson(data)).toList();
    return patientList;
  }

  static List<Doctor> createDoctorList(List<dynamic> json) {
    return json.map((item) => Doctor.fromJson(item)).toList();
  }
}
