import 'package:finance/models/task.dart';
import 'package:hive/hive.dart';

class TaskServices {
  Box<Tasks> tasksBox = Hive.box('tasks');

  Future initTask() async {
    await tasksBox.add(Tasks(createTime: DateTime.now(), tasks: []));
    return tasksBox.length;
  }

  Future addTask(Task task) async {
    Box<Tasks> tasksBox = Hive.box('tasks');

    var current = DateTime.now();

    // get index of matched items
    var ss = tasksBox.get('tasks');
    print(ss);
    var index = tasksBox
        .get('tasks')
        .tasks
        .indexWhere((element) => element.dateTime.difference(current).inDays == 0);
    if (index == 0) {
      // no have
      tasksBox.putAt(index, Tasks(tasks: []..add(task)));
    } else {
      // have
      tasksBox.add(Tasks(createTime: DateTime.now(), tasks: []));
    }
  }
}
