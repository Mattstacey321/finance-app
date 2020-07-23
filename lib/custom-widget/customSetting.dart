import 'package:finance/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSetting extends StatelessWidget {
  final String title;
  final Function onTap;
  final List<Widget> childs;
  CustomSetting({this.title,this.onTap, this.childs});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> onTap(),
      splashColor: Colors.grey.withOpacity(0.2),
      child: Container(
        height: 50,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(
              title,
              style: AppStyle.profileSettingTitle,
            ),
            for (var widget in childs) widget
          ],
        ),
      ),
    );
  }
}
