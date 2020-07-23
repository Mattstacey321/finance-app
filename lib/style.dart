import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  static TextStyle get profileSettingTitle {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  }

  static HeaderStyle tableCalendarHeaderStyle(bool isDarkMode) {
    return HeaderStyle(
      leftChevronIcon: Icon(Icons.chevron_left, color: Get.isDarkMode ? Colors.white : Colors.black),
      rightChevronIcon: Icon(Icons.chevron_right, color: Get.isDarkMode? Colors.white : Colors.black),
      formatButtonVisible: false,
    );
  }
}
