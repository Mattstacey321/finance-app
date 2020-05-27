import 'package:finance/models/task.dart';
import 'package:finance/services/task_services.dart';
import 'package:finance/util/checkTime.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodayProvider extends ChangeNotifier {
  TaskServices _services = TaskServices();
  Box<Tasks> taskBox = Hive.box('tasks');
  int _totalTask = 0;
  int _totalMoney = 0;
  var _task = <Task>[];
  var _currentTask = <Task>[];
  int _originalLength = 0;

  get totalTask => _totalTask;
  get totalMoney => _totalMoney;
  get taskLength => _task.length;

  get currentTask => _currentTask;
  get totalCurrentTask => _currentTask.length;

  void setTotalTask(int total) => _totalTask = total;
  List<Task> get tasks => _task;

  void initTask() {
    //_services.initTask();

    taskBox.values.lastWhere((element) => isDifference(element.key)).tasks.forEach((element) {
      _task.insert(0, Task(title: element.title, dateTime: element.dateTime, money: element.money));
      _totalMoney = _totalMoney + element.money;
    });
    _originalLength = _task.length;

    print("task length ${_task.length}");
    /*taskBox.get('tasks').key  .tasks.forEach((e) {
      _task.add(Task(dateTime: e.dateTime,money: e.money,title: e.title));
    });*/

    notifyListeners();
  }

  Future addTask(Task task) async {
    await _services.addTask(task);
    _task.insert(0, task);
    notifyListeners();
  }

  List<Task> countTask(DateTime selectedDay) {
    _currentTask.clear();
    try {
      var tasks = taskBox.values.singleWhere((element) {
        return selectedDay.difference(DateTime.parse(element.key)).inDays == 0;
      }).tasks;
      //print(tasks.length);
      _currentTask.addAll(tasks);
    } catch (e) {
      return _currentTask;
    }
    return _currentTask;
  }
}
