import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';
import '../models/user_model.dart';

const String USERDATA = "UserData";
const String FCMKEY = "fcm_token";
const String CATEGORY = "category";

class SharedPref {
  final String isDark = "isDark";
  late SharedPreferences prefs;
  static const String _loggedInKey = 'loggedIn';

  Future<void> setSharedPreferences(UserModel usermodel) async {
    prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(usermodel);
    prefs.setString(USERDATA, jsonString);
  }

  Future<UserModel?> getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(USERDATA);
    UserModel userModel = UserModel.fromJson(jsonDecode(jsonString!));
    prefs.setString(USERDATA, jsonString);
    return userModel;
  }

  Future<void> setCategory(Category categroy) async {
    prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(categroy);
    prefs.setString(CATEGORY, jsonString);
  }

  Future<Category?> getCategory() async {
    prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(CATEGORY);
    Category categroy = Category.fromJson(jsonDecode(jsonString!));
    if (jsonString == null) {
      return null;
    }
    prefs.setString(USERDATA, jsonString);
    return categroy;
  }

  retrieveStringValue() async {
    prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("username");
    print(value);
  }

  Future<void> storeFCMToken(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(FCMKEY, fcmToken);
  }

  Future<String?> getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(FCMKEY);
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

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }

  static Future<void> removeUserModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userModel');
  }

  updateData(UserModel userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', userModelToJson(userData));
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
