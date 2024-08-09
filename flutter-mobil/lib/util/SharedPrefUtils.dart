import 'package:blood_check/httprequest/HttpRequestFirebase.dart';
import 'package:blood_check/model/enums/user/EnumUserProp.dart';
import 'package:blood_check/model/firebase/FcmToken.dart';
import 'package:blood_check/model/user/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FcmTokenUtils.dart';

class SharedPrefUtils {
  static var _sp = null;

  static Future<void> setLoginDataUser(User user) async {
    await initiliazeSharedPref();
    _addDataToSP(user);
  }

  static Future<void> initiliazeSharedPref() async {
    _sp ??= await SharedPreferences.getInstance(); // if null, create instance
  }

  static void _addDataToSP(User user) {
    _sp.setInt(EnumUserProp.ID.name, user.id);
    _sp.setInt(EnumUserProp.ROLE_ID.name, user.roleId);
    _sp.setString(EnumUserProp.USERNAME.name, user.username);
    _sp.setString(EnumUserProp.PASSWORD.name, user.password);
    _sp.setString(EnumUserProp.NAME.name, user.name);
    _sp.setString(EnumUserProp.LASTNAME.name, user.lastname);
    saveToken();
  }

  static void saveToken() {
    FcmToken fcmToken = FcmToken(
        userId: SharedPrefUtils.getUserId(), token: FcmTokenUtils.getToken());
    HttpRequestFirebase.saveToken(fcmToken);
  }

  static int getRoleId() {
    var value = _sp.getInt(EnumUserProp.ROLE_ID.name);
    return value ?? -1;
    return _sp.getInt(EnumUserProp.ROLE_ID.name);
  }

  static int getUserId() {
    var value = _sp.getInt(EnumUserProp.ID.name);
    return value ?? -1;
    // return _sp.getInt(EnumUserProp.ID.name);
  }

  static String getUsername() {
    var value = _sp.getString(EnumUserProp.USERNAME.name);
    return value ?? "";
  }

  static String getPassword() {
    var value = _sp.getString(EnumUserProp.PASSWORD.name);
    return value ?? "";
    // return _sp.getString(EnumUserProp.PASSWORD.name);
  }

  static String getName() {
    var value = _sp.getString(EnumUserProp.NAME.name);
    return value ?? "";
    // return _sp.getString(EnumUserProp.NAME.name);
  }

  static String getLastname() {
    var value = _sp.getString(EnumUserProp.LASTNAME.name);
    return value ?? "";
    // return _sp.getString(EnumUserProp.LASTNAME.name);
  }

  static get sp => _sp;
}
