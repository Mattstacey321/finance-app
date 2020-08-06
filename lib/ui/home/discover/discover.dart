import 'package:finance/controller/homeController.dart';
import 'package:finance/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/customTableCalendar.dart';

class Discover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: "task",
        builder: (model) {
          print(
              "debug: tasks count = ${model.countCurrentTask} for ${model.calendarController.focusedDay}");
          var tasks = model.currentTask;
          return Scaffold(
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