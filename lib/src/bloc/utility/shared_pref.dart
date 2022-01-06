import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ufone_web/src/model/User.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/String.dart';

class SharedPref {
  SharedPref();

  SharedPref.createInstance();

  Future<void> setCurrentUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    if (user != null) {
      Map<String, dynamic> result = user.toJson();
      String jsonUser = jsonEncode(result);
      prefs.setString(AppString.CURRENT_USER, jsonUser);
    } else {
      prefs.setString(AppString.CURRENT_USER, "");
    }
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String result = prefs.getString(AppString.CURRENT_USER);
    if (result != null) {
      Map<String, dynamic> map = jsonDecode(result);
      return User.fromJson(map);
    } else
      return null;
  }

  Future<bool> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppString.TOKEN, token);
    return true;
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppString.TOKEN);
  }
}
