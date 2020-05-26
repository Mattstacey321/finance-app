import 'package:finance/custom-widget/taskItem.dart';
import 'package:flutter/material.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 20,
          ),
          itemCount: 1,
          itemBuilder: (context, index) {
            return TaskItem(
              title: "ABCaskhdsakjhd",
              money: 25000,
            );
          },
        ),
      ),
    );
  }
}
