import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class AppStyle {
  static TextStyle get titleMoneyProfile {
    return TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  }

  static TextStyle get homeMoneyTitleFloatingButton {
    return TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  }

  static TextStyle get titleCreateTaskBottomSheet {
    return TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold);
  }

  static TextStyle get titleSubCreateTaskBottomSheet{
    return TextStyle(color: Colors.grey[400], fontSize: 15, fontWeight: FontWeight.bold);
  }

  static TextStyle get profileSettingTitle {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  }

  static BorderRadius bottomSheetBorder =
      BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));

  static HeaderStyle tableCalendarHeaderStyle() {
    return HeaderStyle(
        leftChevronIcon:
            Icon(Icons.chevron_left, color: Get.isDarkMode ? Colors.white : Colors.black),
        rightChevronIcon:
            Icon(Icons.chevron_right, color: Get.isDarkMode ? Colors.white : Colors.black),
        formatButtonVisible: false,
        centerHeaderTitle: true);
  }

  static ThemeData get lightTheme {
    return ThemeData(backgroundColor: Colors.white);
  }

  static ThemeData get darkTheme {
    return ThemeData(backgroundColor: Colors.black, buttonColor: Colors.indigo);
  }

  static List<GButton> customTab = [
    GButton(
      icon: FeatherIcons.activity,
      text: 'Today',
    ),
    GButton(
      icon: FeatherIcons.check,
      text: 'Discover',
    ),
    GButton(
      icon: FeatherIcons.barChart2,
      text: 'Statistics',
    ),
    GButton(
      icon: FeatherIcons.user,
      text: 'Profile',
    ),
  ];
}
