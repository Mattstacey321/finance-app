import 'package:finance/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSetting extends StatelessWidget {
  final String title;
  final bool isClickable;
  final Function onTap;
  final List<Widget> childs;
  CustomSetting({@required this.title, this.isClickable = true, @required  this.onTap, @required this.childs});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isClickable ? () => onTap() : null,
        splashColor: Colors.grey.withOpacity(0.2),
        
        //enableFeedback: onTap() != null ? true : false,
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
      ),
    );
  }
}
