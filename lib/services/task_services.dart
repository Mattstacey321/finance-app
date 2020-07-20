import 'package:finance/models/task.dart';
import 'package:finance/util/checkTime.dart';
import 'package:hive/hive.dart';

class TaskServices {
  Box<Tasks> tasksBox = Hive.box('tasks');

  List<Task> initTask() {
    return tasksBox.values
        .singleWhere((e) => isDifference(compareTime: e.createTime.toString()), orElse: () => Tasks(createTime: DateTime.now().toString(),tasks: []))
        .tasks;
  }

  List<Task> getTaskByDate(DateTime selectedDay) {
    print("you choose $selectedDay");
    return tasksBox.values
        .singleWhere((e) => DateTime.parse(e.key).day == selectedDay.day,
            orElse: () => Tasks())
        .tasks;
  }

  void addTask(Task task) {
    print(task);
    var current = DateTime.now().toString();

    String key = tasksBox.values.isEmpty
        ? current
        : tasksBox.values.singleWhere((element) => isDifference(compareTime: task.dateTime.toString())).key;

    print("Match time by key: $key");
    if (key != null && tasksBox.isNotEmpty) {
      tasksBox.get(key).tasks.add(task);
      tasksBox.get(key).save();
      //  tasksBox.put(key, Tasks(tasks: [task]));
      tasksBox.values.forEach((element) {
        print(element.tasks.toString());
      });
    } else {
      // no have
      print("no have");
      tasksBox.put(current.toString(), Tasks(createTime: DateTime.now().toString(), tasks: []));
      tasksBox.get(key).tasks.add(task);
      tasksBox.get(key).save();
    }
  }
}
