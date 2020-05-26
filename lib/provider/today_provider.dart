import 'package:finance/models/task.dart';
import 'package:finance/services/task_services.dart';
import 'package:flutter/material.dart';

class TodayProvider extends ChangeNotifier {
  TaskServices _services = TaskServices();
  int _totalTask = 0;
  int _totalMoney = 0;
  var _task = <Task>[];

  get totalTask => _totalTask;
  get totalMoney => _totalMoney;

  void setTotalTask(int total) => _totalTask = total;
  List<Task> get tasks => _task;

  Future initTask() async {
    var result = await _services.initTask();
    print("Load task: ${result}");
    this.setTotalTask(result);
  }

  Future addTask(Task task) async {
    await _services.addTask(task);
    notifyListeners();
  }
}
