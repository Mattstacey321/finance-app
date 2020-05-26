import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData child;
  final Function onTap;
  final double iconSize;
  const CircleIcon({@required this.onTap,this.iconSize = 20, @required this.child});
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      type: MaterialType.circle,
      color: Colors.transparent,
      child: IconButton(icon: Icon(child), onPressed: onTap,iconSize: iconSize,),
    );
  }
}
