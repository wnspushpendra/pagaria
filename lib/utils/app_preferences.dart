import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webnsoft_solution/modal/login/login_response.dart';

setBoolPref(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}
Future<bool?> getBoolPref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? value = prefs.getBool(key);
  return value;
}

setStringPref(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

getStringPref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString(key);
  return stringValue;
}
setIntPref(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}
Future<int?> getIntPref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? value = prefs.getInt(key);
  return value;
}

clearPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}


Future<void> saveUserPref(User value,String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userJson = json.encode(value.toJson()); // Convert User object to JSON string
  await prefs.setString(key, userJson); // Save JSON string in SharedPreferences
}

Future<User> getUserPref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString(key);
  Map<String, dynamic> userMap = json.decode(userJson!);
  return User.fromJson(userMap);
}
