import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsAnimation extends StatefulWidget {
  @override
  SstatisticsStateAnimation createState() => SstatisticsStateAnimation();
}

class SstatisticsStateAnimation extends State<StatisticsAnimation> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    Tween<double> _rotationTween = Tween(begin: 0, end: 1);
    animation = _rotationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: ShapePainter(),
        child: Container(),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    var path = Path();
    path.lineTo(0, size.height - 10);

    var firstControlPoint =  Offset(0, size.height - 20);
    var firstEndPoint =  Offset(size.width / 2, size.height / 3 - 60);

    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
