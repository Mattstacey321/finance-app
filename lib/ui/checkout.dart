import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/controller/homeController.dart';
import 'package:finance/custom-widget/FaSlideUp.dart';
import 'package:finance/custom-widget/taskItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (model) {
      print("debug: tasks count = ${model.totalCurrentTask} for ${_calendarController.focusedDay}");
      var tasks = model.currentTask;
      int countTasks = tasks.length;
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _calendarController.setSelectedDay(DateTime.now().toLocal(),
                  animate: true, isProgrammatic: true, runCallback: true);
            });
          },
          child: Icon(FeatherIcons.bookmark),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaSlideAnimation.slideUp(
                delayed: 200,
                show: true,
                child: TableCalendar(
                  initialCalendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: (day, events) => model.getCurrentTask(day),
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

                      return buildDay(date, countTasks);
                    },
                    todayDayBuilder: (context, date, events) {
                      // show 0 if that day doesn't have any task.

                      return buildDay(date, 0);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: tasks.isEmpty
                      ? Center(
                          child: Text("You have no task today!"),
                        )
                      : FaSlideAnimation.slideUp(
                          delayed: 200,
                          show: true,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemCount: model.totalCurrentTask,
                            itemBuilder: (context, index) {
                              return TaskItem(
                                title: tasks[index].title,
                                money: tasks[index].money,
                                location: "ABC",
                                time: tasks[index].dateTime.toString(),
                                type: "Eat  ",
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget buildDay(DateTime date, int value) {
  return Container(
    width: 40,
    height: 40,
    margin: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: date.day == DateTime.now().day ? Colors.orange[100] : Colors.lightBlue[100]),
    child: Stack(
      children: [
        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.black),
                ))),
        Positioned(
            right: -1,
            bottom: -1,
            child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: date.day == DateTime.now().day ? Text("0") : Text("$value")))
        //  : Container()
      ],
    ),
  );
}
