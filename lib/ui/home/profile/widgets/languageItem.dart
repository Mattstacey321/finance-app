import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageItem extends StatefulWidget {
  final Function onTap;
  final bool isChecked;
  final List<Widget> childs;
  LanguageItem({this.isChecked = false, this.onTap, this.childs});

  @override
  _LanguageItemState createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400))
      ..addListener(() {});
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (controller.isCompleted) {
          controller.reset();
          controller.forward();
        }
        return widget.onTap();
      },
      splashColor: Colors.grey.withOpacity(0.2),
      child: Container(
        height: 50,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              child: FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
                  child: widget.isChecked ? Icon(FeatherIcons.check) : SizedBox(width: 25)),
            ),
            SizedBox(width: 15),
            for (var widget in widget.childs) widget
          ],
        ),
      ),
    );
  }
}
