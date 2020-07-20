import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Function onPress;
  final String tooltip;
  final double radius;
  final IconData icon;
  final Color iconColor;
  final double opacity;
  final bool isClickable;
  final List<Widget> childs;
  CustomButton(
      {@required this.height,
      @required this.width,
      this.radius = 15,
      @required this.onPress,
      @required this.tooltip,
      @required this.iconColor,
      this.isClickable = true,
      this.opacity = 0.2,
      this.childs,
      @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        splashColor: iconColor.withOpacity(0.1),
        onTap: isClickable ? () => this.onPress() : null,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius), color: iconColor.withOpacity(opacity)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: height * 0.6),
              childs != null ? SizedBox(width: 10) : SizedBox(width: 0),
              for (var widget in childs ?? []) widget
            ],
          ),
        ),
      ),
    );
  }
}
