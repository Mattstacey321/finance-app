import 'package:finance/controller/homeController.dart';
import 'package:finance/custom-widget/FaSlideUp.dart';
import 'package:finance/custom-widget/customTableCalendar.dart';
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
    return GetBuilder<HomeController>(
        id: "task",
        builder: (model) {
          print(
              "debug: tasks count = ${model.countCurrentTask} for ${_calendarController.focusedDay}");
          var tasks = model.currentTask;

          return Scaffold(
            /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _calendarController.setSelectedDay(DateTime.now().toLocal(),
                  animate: true, isProgrammatic: true, runCallback: true);
            });
          },
          child: Icon(FeatherIcons.bookmark),
          backgroundColor: Colors.indigo,
        ),*/
            body: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FaSlideAnimation.slideUp(
                      delayed: 200,
                      show: true,
                      child: CustomTableCalendar(
                          //isDarkMode: model.isDarkMode,

                          onDaySelected: (day) => model.getCurrentTask(day),
                          countTask: model.countCurrentTask,
                          countTodayTask: model.countTodayTask)),
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
                                itemCount: model.countCurrentTask,
                                itemBuilder: (context, index) {
                                  return TaskItem(
                                    title: tasks[index].title,
                                    money: tasks[index].money,
                                    location: tasks[index].location,
                                    time: tasks[index].dateTime.toString(),
                                    onTapped: () {
                                      return model.removeTask(
                                          index: index, time: tasks[index].dateTime.toString());
                                    },
                                    type: "Eat",
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
