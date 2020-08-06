import 'package:finance/controller/home_controller.dart';
import 'package:finance/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  final Function onDaySelected;
  final int countTask;
  final int totalMoney;
  final int countTodayTask;
  final bool isDarkMode;
  const CustomTableCalendar(
      {@required this.onDaySelected,
      this.isDarkMode = false,
      this.countTask = 0,
      this.totalMoney = 0,
      this.countTodayTask = 0});

  @override
  _CustomTableCalendarState createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar>
    with SingleTickerProviderStateMixin {
  CalendarController _calendarController = CalendarController();
  AnimationController _controller;
  final HomeController h = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TableCalendar(
          initialCalendarFormat: CalendarFormat.week,
          headerStyle: AppStyle.tableCalendarHeaderStyle(),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
          ),
          dayHitTestBehavior: HitTestBehavior.translucent,
          formatAnimation: FormatAnimation.slide,
          rowHeight: 60,
          onDaySelected: (day, events) => widget.onDaySelected(day),
          calendarController: _calendarController,
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          builders: CalendarBuilders(
            dayBuilder: (context, date, events) {
              // count task here
              return Container(
                width: 40,
                height: 60,
                alignment: Alignment.center,
                child: Text("${date.day}"),
              );
            },
            selectedDayBuilder: (context, date, events) {
              //print("u click $date");
              //get task detail

              return buildDay(date, widget.countTask);
            },
            todayDayBuilder: (context, date, events) {
              // show 0 if that day doesn't have any task.

              return buildDay(date, widget.countTodayTask);
            },
          ),
        ),
        Divider(),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    "Today",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Spacer(),
                  Text("${widget.totalMoney} đ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget buildDay(DateTime date, int value) {
  return Container(
    width: 60,
    height: 60,
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: date.day == DateTime.now().day ? Colors.orange : Colors.lightBlue[100]),
    child: Stack(
      children: [
        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: Text(date.day.toString(),
                    style: date.day == DateTime.now().day
                        ? TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                        : TextStyle(
                            color: Colors
                                .lightBlue[600], //Theme.of(Get.context).textTheme.bodyText1.color,
                            fontWeight: FontWeight.bold)))),
        Positioned(
            right: 0,
            bottom: -2,
            child: Container(
                height: 20,
                width: 40,
                alignment: Alignment.bottomCenter,
                /*decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: date.day == DateTime.now().day 
                  ? Colors.orange[100]
                  :Colors.black,
                ),*/
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    value > 3
                        ? Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                            child: Text("+$value"),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(width: 2),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: value,
                            itemBuilder: (ctx, index) {
                              return Icon(
                                Icons.fiber_manual_record,
                                size: 10,
                                color: Colors.orange[900],
                              );
                            })
                  ],
                )

                /* ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 2),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: value,
                    itemBuilder: (ctx, index) {
                      if (value > 3) {
                        return Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                          child: Text("+$value"),
                        );
                      } else {
                        return Icon(
                          Icons.fiber_manual_record,
                          size: 10,
                          color: Colors.orange[900],
                        );
                      }
                    })*/

                ))
        //  : Container()
      ],
    ),
  );
}
