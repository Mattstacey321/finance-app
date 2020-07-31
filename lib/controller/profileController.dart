import 'package:finance/controller/themeController.dart';
import 'package:finance/custom-widget/customButton.dart';
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

  Future logout() async {
    return Get.defaultDialog(
        title: "Log out",
        cancel: CustomButton(
          onPress: () {},
          iconColor: Colors.blue,
          tooltip: 'Cancel',
          radius: 10,
          childs: [Text("Cancel")],
        ),
        confirm: CustomButton(
          onPress: () {},
          iconColor: Colors.red,
          tooltip: 'Confirm',
          radius: 10,
          childs: [Text("Confirm")],
        ),
        radius: 15,
        content: Container(
          height: 50,
          width: Get.width,
          alignment: Alignment.center,
          child: Text("Do you want to log out ?"),
        ));
  }
}
