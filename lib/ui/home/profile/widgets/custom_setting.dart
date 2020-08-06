import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/theme/style.dart';
import 'package:finance/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSetting extends StatelessWidget {
  final double height;
  final Color iconColor;
  final IconData icon;
  final String title;
  final bool isClickable;
  final Function onTap;
  final List<Widget> childs;
  CustomSetting(
      {@required this.title,
      this.height = 60,
      this.iconColor,
      @required this.icon,
      this.isClickable = true,
      @required this.onTap,
      @required this.childs});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isClickable ? () => onTap() : null,
        splashColor: Colors.grey.withOpacity(0.2),

        //enableFeedback: onTap() != null ? true : false,
        child: Container(
          height: height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              CustomButton(
                onPress: null,
                isClickable: false,
                tooltip: "",
                iconColor: iconColor,
                icon: icon,
                
                height: height - height * 0.25,
                width: height - height * 0.25,
              ),
              SizedBox(width: 10),
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
