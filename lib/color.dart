import 'package:flutter/material.dart';

class AppColor with GradientColor {
  static GradientColor gradientColor = GradientColor();
}

class GradientColor {
  LinearGradient whoseProduct = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      
      colors: [ Color(0xffdc985b),Color(0xfffdb73c)]);
  LinearGradient juicyPeach = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      
      colors: [ Color(0xfffcb69f),Color(0xfffffecd2)]);
  LinearGradient myCustom = LinearGradient(
      begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Colors.blue, Colors.red]);
}
