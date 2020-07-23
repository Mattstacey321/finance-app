import 'package:finance/controller/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;
  void switchTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    ThemeController.to.updateThemeModeToPreferences(value: _isDarkMode.value);
  }

  void changeLanguage() {}
}
