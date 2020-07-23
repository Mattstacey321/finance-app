import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();
  SharedPreferences prefs;
  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  updateThemeModeToPreferences({@required bool value}) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("darkMode", value);
  }

  Future<bool> getThemeModeFromPreferences() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getBool("darkMode") ?? false;
  }
  updateDefaultLanguageToPrefrences({String locate }) async{
    prefs = await SharedPreferences.getInstance();
    prefs.setString("language", locate);
  }
  Future<String> getLanguageFromPreferences() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("language");
  }
}
