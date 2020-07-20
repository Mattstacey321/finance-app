import 'package:finance/models/task.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

Future initHive() async {
  var appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('task');
  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('tasks');
  //await Hive.openBox('task')
}
