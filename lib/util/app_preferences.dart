import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static late SharedPreferences _prefs;

  static Future initMySharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void clearSharedPreferences() {
    _prefs.clear();
    return;
  }

  static Future setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String getString(String key) {
    final String? value = _prefs.getString(key);
    return value ?? "";
  }

  static Future setBoolean(String key, {required bool value}) async {
    await _prefs.setBool(key, value);
  }

  static bool getBoolean(String key) {
    final bool? value = _prefs.getBool(key);
    return value ?? false;
  }

  static Future setLong(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  static double getLong(String key) {
    final double? value = _prefs.getDouble(key);
    return value ?? 0.0;
  }

  static Future setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static int getInt(String key) {
    final int? value = _prefs.getInt(key);
    return value ?? 0;
  }

  // static String? getUserToken() {
  //   return _prefs.get(Constants.keyToken) as String?;
  // }

  // static bool isUserLogin() {
  //   final String? getToken = getUserToken();
  //   return getToken != null && getToken.isNotEmpty;
  // }
  static Future setSearchList(String key, List<String> search) async {
    await _prefs.setStringList(key, search);
  }
  static List<String> getSearchList(String key) {
    return _prefs.getStringList(key)??[];
  }
}
