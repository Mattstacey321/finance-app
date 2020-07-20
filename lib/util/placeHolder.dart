import 'package:flutter/material.dart';

class Skeleton {
  static Color _lightGrey = Colors.grey.withOpacity(0.2);
  static image(
      {double height, double width, Color color, double borderRadius}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(color: color ?? _lightGrey, borderRadius: BorderRadius.circular(borderRadius)),
    );
  }
}
