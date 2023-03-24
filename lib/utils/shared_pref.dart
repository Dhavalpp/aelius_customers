import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  final String isDark = "isDark";
  late SharedPreferences prefs;

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("username", "naresh");
    prefs.setString("mobile", "phone no");
    prefs.setString("username", "phone no");
    prefs.setString("imgURL", "url");
    prefs.setString("Category", "categories");
    prefs.setString("pincode", "zipcode");
    prefs.setString("region", "region");
    prefs.setString("username", "");

    prefs.setInt("customer_id", 0);
    prefs.setInt("member_id", 0);
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

  final String login = "islogin";

  Future<void> setLogin(bool isLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(this.login, isLogin);
  }

  Future<bool> getLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLogin;
    isLogin = pref.getBool(this.login) ?? false;
    return isLogin;
  }
}
