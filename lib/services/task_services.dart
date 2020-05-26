import 'package:finance/models/task.dart';
import 'package:finance/util/checkTime.dart';
import 'package:hive/hive.dart';

class TaskServices {
  Box<Tasks> tasksBox = Hive.box('tasks');



  Future addTask(Task task) async {
    // Box<Tasks> tasksBox = Hive.box('tasks');

    var current = DateTime.now().toString();

    String key = tasksBox.values.isEmpty
        ? current
        : tasksBox.values.singleWhere((element) => isDifference(task.dateTime.toString())).key;
    print("Match time by key: $key");
    // .indexWhere((element) => element.dateTime.difference(current).inDays == 0);
    if (key != null) {
      tasksBox.get(key).tasks.add(task);
      tasksBox.get(key).save();
      //  tasksBox.put(key, Tasks(tasks: [task]));
      tasksBox.values.forEach((element) {
        print(element.tasks.toString());
      });
      /* if (parseDate(index).difference(current).inDays == 0) {
        print("Same value");
       
      }*/

      //tasksBox.put(index, Tasks(tasks: []..add(task)));
    } else {
      // no have
      print("no have");
      tasksBox.put(current.toString(), Tasks(createTime: DateTime.now().toString(), tasks: []));
    }
  }
}
