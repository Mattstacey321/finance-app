import 'package:flutter/material.dart';

class ThemeSwitcher extends StatefulWidget {
  final Function onTap;
  final bool isDarkMode;

  const ThemeSwitcher({this.onTap, this.isDarkMode});
  @override
  _ThemeSwitcherState createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> with TickerProviderStateMixin {
  Animation animation;
  Animation slideAnimation;
  AnimationController animationController;
  bool isCheck = false;
  double _circleSize = 25;
  double _widgetWidth = 100;
  double _widgetHeight = 40;
  int _animationDuration = 200;
  double startPos = -1.0;
  double endPos = 0.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      isCheck = widget.isDarkMode;
      print("theme is $isCheck");
    });

    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)..addListener(() {});
    if (isCheck) {
      setState(() {
        setState(() {
          startPos = 0.0;
          endPos = 1.0;
        });
        animationController.forward();
      });
    }
    //animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () {
        print("theme is click $isCheck");
        setState(() {
          if (isCheck) {
            animationController.forward();
            setState(() {
              startPos = 2.0;
              endPos = 0.0;
            });
          } else {
            setState(() {
              startPos = 0.0;
              endPos = 1.0;
            });
            animationController.reverse();
          }
          isCheck = !isCheck;
        });
        return widget.onTap();
      },
      child: Container(
        width: _widgetWidth - 20,
        height: _widgetHeight,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
            offset: Offset(1, 1),
          )
        ]),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: _animationDuration),
                  width: _widgetWidth,
                  height: _widgetHeight,
                  decoration: BoxDecoration(
                      color: isCheck ? ThemeData.dark().primaryColor : Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.2), width: 2),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            Container(
              width: _widgetWidth,
              height: _widgetHeight,
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: TweenAnimationBuilder(
                  duration: Duration(seconds: 1),
                  curve: Curves.linearToEaseOut,
                  tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
                  builder: (context, offset, child) => FractionalTranslation(
                        translation: offset,
                        child: isCheck
                            ? Text(
                                "Dark",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              )
                            : Text("Light",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      )),
            ),
            AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: isCheck ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  height: _circleSize,
                  width: _circleSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: isCheck ? Colors.white : Colors.black),
                )),
          ],
        ),
      ),
    );
  }
}
