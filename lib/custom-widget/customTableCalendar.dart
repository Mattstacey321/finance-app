import 'package:finance/controller/profileController.dart';
import 'package:finance/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  final Function onDaySelected;
  final int countTask;
  final int todayTask;
  final bool isDarkMode;
  const CustomTableCalendar(
      {@required this.onDaySelected,
      this.isDarkMode = false,
      this.countTask = 0,
      this.todayTask = 0});

  @override
  _CustomTableCalendarState createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      initialCalendarFormat: CalendarFormat.week,
      headerStyle: AppStyle.tableCalendarHeaderStyle(widget.isDarkMode),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
      ),
      onDaySelected: (day, events) => widget.onDaySelected(day),
      calendarController: _calendarController,
      builders: CalendarBuilders(
        dayBuilder: (context, date, events) {
          // count task here

          return Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(4.0),
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

          return buildDay(date, widget.todayTask);
        },
      ),
    );
  }
}

Widget buildDay(DateTime date, int value) {
  return Container(
    width: 40,
    height: 40,
    margin: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: date.day == DateTime.now().day
            ? Border.all(color: Colors.orange[100])
            : Border.all(color: Colors.transparent),
        color: date.day == DateTime.now().day ? Colors.transparent : Colors.lightBlue[100]),
    child: Stack(
      children: [
        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: Text(date.day.toString(),
                    style: date.day == DateTime.now().day
                        ? TextStyle(color: Colors.orange[100], fontWeight: FontWeight.bold)
                        : TextStyle(
                            color: Colors
                                .lightBlue[600], //Theme.of(Get.context).textTheme.bodyText1.color,
                            fontWeight: FontWeight.bold)))),
        Positioned(
            right: 0,
            bottom: -3,
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
                      }
                    )
                        
                
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
