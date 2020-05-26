import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  int money;
  @HiveField(2)
  DateTime dateTime;
  Task({this.title, this.money, this.dateTime});
}

@HiveType(typeId: 1)
class Tasks extends HiveObject {
  @HiveField(0)
  String createTime;
  @HiveField(1)
  List<Task> tasks;
  Tasks({this.createTime,this.tasks});
}
