import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width,
      child: RangeSlider(
        min: 0,
        max: 100,
        values : RangeValues(0, 100),labels: RangeLabels("start", "end"), onChanged: (value){}),
    );
  }
}
