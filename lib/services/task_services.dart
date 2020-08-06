import 'package:finance/models/task.dart';
import 'package:finance/util/check_time.dart';
import 'package:hive/hive.dart';

class TaskServices {
  Box<Tasks> tasksBox = Hive.box('tasks');
  Tasks emptyTask = Tasks(tasks: [], createTime: DateTime.now().toString(),totalMoney: 0);

  List<Task> initTask() {
    var current = DateTime.now().toString();
    bool isKeyExist = tasksBox.values.any((e) => checkKeyExist(e.key));
    print("debug: initTask -> $isKeyExist");
    if (isKeyExist) {
      return tasksBox.values.lastWhere((e) {
        return isDifference(compareTime: e.key);
      }, orElse: () => emptyTask).tasks;
    } else {
      tasksBox.put(current.toString(), emptyTask);
      return [];
    }
    /*String key = tasksBox.values.isEmpty
        ? current
        : tasksBox.values
            .singleWhere((element) => isDifference(compareTime: task.dateTime.toString()))
            .key;*/
  }

  checkKeyExist(String createTime) {
    return isDifference(compareTime: createTime);
  }

  List<Task> getTaskByDate(DateTime selectedDay) {
    print("you choose $selectedDay");

    return tasksBox.values.singleWhere((e) {
      return isKeyDifference(compareTime: selectedDay.toString(), selectTime: e.createTime);
    }, orElse: () => emptyTask).tasks;
  }

  int getTotalMoneyByDate(DateTime dateTime){
    return tasksBox.values.singleWhere((e) {
      return isKeyDifference(compareTime: dateTime.toString(), selectTime: e.createTime);
    }, orElse: () => emptyTask).totalMoney;
  }

  void addTask(Task task) {
    var current = DateTime.now().toString();

    String key = tasksBox.values.isEmpty
        ? current
        : tasksBox.values.lastWhere(
            (element) => isDifference(compareTime: task.dateTime.toString()), orElse: () {
            return emptyTask;
          }).key;

    print("Match time by key: $key");
    if (key != null && tasksBox.isNotEmpty) {
      tasksBox.get(key).tasks.add(task);
      tasksBox.get(key).totalMoney += task.money;
      tasksBox.get(key).save();
      //  tasksBox.put(key, Tasks(tasks: [task]));

      /* tasksBox.values.forEach((element) {
        print(element.tasks.toString());
      });*/
    }
    /*else {
      // no have
      print("no have");
      tasksBox.put(current.toString(), Tasks(createTime: DateTime.now().toString(), tasks: []));
      tasksBox.get(key).tasks.add(task);
      tasksBox.get(key).save();
    }*/
  }

  Future removeTask(int index, String time) async {
    String key = tasksBox.values.isEmpty
        ? ""
        : tasksBox.values.singleWhere((element) => isDifference(compareTime: time)).key;
    if (key == "") {
      //key not exist.
      return false;
    } else {
      var result = tasksBox.get(key);
      if (result.taskLength > 0) {
        result.tasks.removeAt(index);
        //update box with key
        tasksBox.get(key).save();
        return true;
      } else {
        return false;
      }
    }
  }
}
