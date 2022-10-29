import 'package:shared_preferences/shared_preferences.dart';

class MyPreference {



  static SharedPreferences ? _sharedPreferences;



  static Future<void> setToken(String authcode) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences!.setString(Constance.authCode, authcode);
  }

  static Future<String> getToken() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences!.getString(Constance.authCode) ?? "";
  }




}


class Constance {
  static String authCode = "token";
}