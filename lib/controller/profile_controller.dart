import 'package:finance/controller/theme_controller.dart';
import 'package:finance/ui/home/profile/widgets/profile_widgets.dart';
import 'package:finance/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math.dart' as math;

import 'home_controller.dart';

class ProfileController extends GetxController {
  var _isDarkMode = false.obs;
  var _locate = "en".obs;
  var _totalMoney = 0.obs;

  @override
  void onInit() {
    ever(_totalMoney, (value) {
      print("value in profileController change $value");
    });
    super.onInit();
  }

  int get totalMoney => HomeController.to.totalMoney;
  bool get isDarkMode => _isDarkMode.value;
  String get appLocate => _locate.value;

  void changeLanguage(String locate) {
    _locate.value = locate;
  }

  void switchTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    ThemeController.to.updateThemeModeToPreferences(value: _isDarkMode.value);
  }

  Future switchLanguage() async {
    return SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      return Get.generalDialog(
        transitionDuration: Duration(milliseconds: 200),
        barrierColor: Colors.black.withOpacity(0.4),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(
            child: Material(
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 10000),
                  height: 100,
                  width: Get.width - 150,
                  decoration:
                      BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Column(children: [
                    SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
                          CurvedAnimation(
                              parent: animation,
                              curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                      child: Obx(
                        () => LanguageItem(
                          isChecked: _locate.value == 'en' ? true : false,
                          onTap: () => changeLanguage('en'),
                          childs: [Text("English")],
                        ),
                      ),
                    ),
                    SlideTransition(
                        position:
                            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(CurvedAnimation(
                          parent: animation,
                          curve: Interval(
                            0.5,
                            1,
                            curve: Curves.fastOutSlowIn,
                          ),
                        )),
                        child: Obx(() => LanguageItem(
                              isChecked: _locate.value == 'vi' ? true : false,
                              onTap: () => changeLanguage('vi'),
                              childs: [Text("Vietnamese")],
                            )))
                  ])),
            ),
          );
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          print(animation.value);
          print(secondaryAnimation.value);
          return Transform.translate(
            offset: Offset(animation.value, animation.value * 15),
            child: Opacity(opacity: animation.value, child: child),
          );
        },
        /*AnimatedContainer(
            duration: Duration(milliseconds: 5000),
            height: 100 + animation.value * 2,
            width: 100 + animation.value,
            child: child,
          ),*/
      );

      /* Get.defaultDialog(
        title: "Change language",
        radius: 10,
        content: Container(
          width: Get.width,
          height: 100,
          child: Column(
            children: [
              Obx(
                () => LanguageItem(
                  isChecked: _locate.value == 'en' ? true : false,
                  onTap: () => changeLanguage('en'),
                  childs: [Text("English")],
                ),
              ),
              Obx(() => LanguageItem(
                    isChecked: _locate.value == 'vi' ? true : false,
                    onTap: () => changeLanguage('vi'),
                    childs: [Text("Vietnamese")],
                  ))
            ],
          ),
        ),
        cancel: CustomButton(
          onPress: () {
            Get.back();
          },
          iconColor: Colors.blue,
          tooltip: 'Cancel',
          radius: 10,
          childs: [Text("Cancel")],
        ),
        confirm: CustomButton(
          onPress: () {
            Get.back();
          },
          iconColor: Colors.red,
          tooltip: 'Confirm',
          radius: 10,
          childs: [Text("Confirm")],
        ),
      );*/
    });
  }

  Future logout() async {
    Get.defaultDialog(
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
