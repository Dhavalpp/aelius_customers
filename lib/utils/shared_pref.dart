import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

const String USERDATA = "UserData";

class SharedPref {
  final String isDark = "isDark";
  late SharedPreferences prefs;

  Future<void> setSharedPreferences(UserModel usermodel) async {
    prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(usermodel);
    prefs.setString(USERDATA, jsonString);
  }

  Future<UserModel?> getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(USERDATA);
    UserModel userModel = UserModel.fromJson(jsonDecode(jsonString!));
    if (jsonString == null) {
      return null;
    }
    return userModel;
    prefs.setString(USERDATA, jsonString);
  }

  retrieveStringValue() async {
    prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("username");
    print(value);
  }

  Future<void> setScreenData(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(this.isDark, isDark);
  }

  Future<bool> getScreenData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool isDark;
    isDark = pref.getBool(this.isDark) ?? false;
    return isDark;
  }

  static const String _loggedInKey = 'loggedIn';

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }

//
// Future<void> setLogin(bool isLogin) async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setBool(this.login, isLogin);
// }
//
// Future<bool> getLogin() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   bool isLogin;
//   isLogin = pref.getBool(this.login) ?? false;
//   return isLogin;
// }
}

