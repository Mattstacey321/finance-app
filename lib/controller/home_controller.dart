import 'package:bot_toast/bot_toast.dart';
import 'package:finance/models/task.dart';
import 'package:finance/services/task_services.dart';
import 'package:finance/ui/home/create_task/create_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeController extends GetxController {
  TaskServices _taskServices = TaskServices();
  static HomeController get to => Get.find();
  CalendarController calendarController = CalendarController();

  var _tasks = <Task>[];
  var _currentTasks = [];
  var _totalMoney = 0.obs;

  int get totalMoney {
    var totalMoney = 0;
    for (var item in tasks) {
      totalMoney += item.money;
    }
    return _totalMoney.value = totalMoney;
  }

  int get countCurrentTask => _currentTasks.length;
  int get countTodayTask => _tasks.length;
  List<Task> get tasks => _tasks;
  List get currentTask => _currentTasks;

  @override
  void onInit() {
    initTask();
    super.onInit();
  }

  @override
  void onClose() {
    calendarController.dispose();
    super.onClose();
  }

  void initTask() {
    _tasks.addAll(_taskServices.initTask());
    _currentTasks.addAll(_taskServices.initTask());
    update();
  }

  getCurrentTask(DateTime currentTime) {
    _currentTasks = [];
    print("hello ${_taskServices.getTaskByDate(currentTime)}");
    _currentTasks.addAll(_taskServices.getTaskByDate(currentTime) ?? []);
    update();
  }

  removeTask({int index, String time}) {
    Get.defaultDialog(
        title: "Delete item ?",
        content: Container(
          height: 50,
          width: Get.width,
          alignment: Alignment.center,
          child: Text("Do you want to log out ?"),
        ),
        radius: 10,
        confirm: FlatButton(
            onPressed: () async {
              if (await _taskServices.removeTask(index, time)) {
                _totalMoney.value -= _tasks[index].money;
                _tasks.removeAt(index);
                _currentTasks.removeAt(index);

                update();
                BotToast.showText(text: "Delete success");
                Get.back();
              } else {
                BotToast.showText(text: "Delete fail");
              }
            },
            child: Text("Delete")),
        cancel: FlatButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel")));
  }

  showAddTask() {
    return Get.bottomSheet(
      CreateTask(),
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      useRootNavigator: true,
      ignoreSafeArea: true,
      isScrollControlled: true,
    );
  }
}
