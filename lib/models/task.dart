import 'package:flutter/cupertino.dart';
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
  @HiveField(3)
  Map location;
  @HiveField(4)
  List type;
  @HiveField(5)
  String description;
  String get dateTimeAsString => dateTime.toString();

  Task(
      {@required this.title,
      @required this.money,
      this.dateTime,
      @required this.location,
      this.description,
      this.type});
}

@HiveType(typeId: 1)
class Tasks extends HiveObject {
  @HiveField(0)
  String createTime;
  @HiveField(1)
  List<Task> tasks;
  int get taskLength => tasks.length;
  Tasks({this.createTime, this.tasks});
}
