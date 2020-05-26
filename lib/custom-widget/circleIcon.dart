import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final double iconSize;

  final bool isCircle;
  const CircleIcon({this.isCircle = true,@required this.onTap, this.iconSize = 20, @required this.child});
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      type: isCircle ? MaterialType.circle : MaterialType.button,
      color: Colors.transparent,
      child: isCircle ? IconButton(
        icon: child,
        onPressed: onTap,
        iconSize: iconSize,
      ) : InkWell(
        child: child
      ),
    );
  }
}
