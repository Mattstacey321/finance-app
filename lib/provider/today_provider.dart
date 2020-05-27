import 'package:finance/models/task.dart';
import 'package:finance/services/task_services.dart';
import 'package:finance/util/checkTime.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodayProvider extends ChangeNotifier {
  TaskServices _services = TaskServices();
  Box<Tasks> taskBox = Hive.box('tasks');
  int _totalTask = 0;
  int _totalCurrentTask = 0;
  int _totalMoney = 0;
  // task today
  var _task = <Task>[];
  // task add base on user click
  var _currentTask = <Task>[];

  int get totalTask => _totalTask;
  int get totalMoney => _totalMoney;
  int get taskLength => _task.length;
  List<Task> get currentTask => _currentTask;
  int get totalCurrentTask => _totalCurrentTask;

  void setTotalTask(int total) => _totalTask = total;

  void setTotalCurrentTask(int total) {
    _totalCurrentTask = total;
    notifyListeners();
  }

  List<Task> get tasks => _task;

  void initTask() {
    taskBox.values.lastWhere((element) => isDifference(element.key)).tasks.forEach((element) {
      _task.insert(0, Task(title: element.title, dateTime: element.dateTime, money: element.money));
      _totalMoney = _totalMoney + element.money;
    });

    notifyListeners();
  }

  Future addTask(Task task) async {
    await _services.addTask(task);
    _task.insert(0, task);
    notifyListeners();
  }

  int countTask(DateTime selectedDay) {
    int tasks = 0;
    try {
      //setTotalCurrentTask(0);
      tasks = taskBox.values
              .singleWhere((element) {
                return selectedDay.difference(DateTime.parse(element.key)).inDays == 0;
              })
              .tasks
              .length ??
          0;
      setTotalCurrentTask(tasks);
      //print(_currentTask.length);
    } catch (e) {
      return 0;
    }
    return tasks;
  }

  List<Task> getTaskDetail(DateTime selectedDay) {
    try {
      _currentTask.clear();
      notifyListeners();
      var tasks = taskBox.values.singleWhere((element) {
        return selectedDay.difference(DateTime.parse(element.key)).inDays.abs() == 0;
      }).tasks;
      _currentTask.addAll(tasks);
      notifyListeners();
    } catch (e) {
      return [];
    }
    return _currentTask;
  }
}
