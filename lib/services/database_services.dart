import 'package:finance/models/task.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
Future initAppDb() async {
  var appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();

  Hive
  ..init(appDocumentDirectory.path)
  ..registerAdapter(TaskAdapter())
  ..registerAdapter(TasksAdapter());
  await Hive.openBox<Task>('task');
  await Hive.openBox<Tasks>('tasks');
}
