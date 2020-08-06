import 'package:flutter/material.dart';
import 'dart:async';

class CustomAnimation extends StatefulWidget {
  final Widget child;
  final bool show;
  final int delayed;
  final Offset offsetStart;
  final Offset offsetEnd;
  CustomAnimation(
      {this.child,
      this.show = true,
      @required this.delayed,
      @required this.offsetStart,
      @required this.offsetEnd});

  factory CustomAnimation.slideUp({Widget child, bool show = true, int delayed}) {
    return CustomAnimation(
        show: show,
        delayed: delayed,
        offsetStart: Offset(0, 1),
        offsetEnd: Offset.zero,
        child: child);
  }
  factory CustomAnimation.slideDown({Widget child, bool show = true, int delayed}) {
    return CustomAnimation(
        show: show,
        delayed: delayed,
        offsetStart: Offset.zero,
        offsetEnd: Offset(0, 0),
        child: child);
  }
  factory CustomAnimation.slideLeft({Widget child, bool show = true, int delayed}) {
    return CustomAnimation(
        show: show,
        delayed: delayed,
        offsetStart: Offset(1, 0),
        offsetEnd: Offset.zero,
        child: child);
  }
  factory CustomAnimation.slideRight({Widget child, bool show = true, int delayed}) {
    return CustomAnimation(
        show: show,
        delayed: delayed,
        offsetStart: Offset.zero,
        offsetEnd: Offset(1, 0),
        child: child);
  }
  @override
  _CustomAnimationState createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween(begin: widget.offsetStart, end: widget.offsetEnd)
        .animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
          ..addListener(() {
            setState(() {});
          });
    widget.show
        ? Timer(Duration(milliseconds: widget.delayed), () {
            if (mounted) {
               controller.forward();
            } else {
             
            }
          })
        : Timer(Duration(milliseconds: widget.delayed), () {
            if (mounted) {
              controller.reverse();
            } else {
              
            }
          });
  }

  @override
  void dispose() {
    if (mounted) {
      controller.dispose();
    } else {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: FadeTransition(
        opacity: controller,
        child: widget.child,
      ),
    );
  }
}
