import 'package:finance/custom-widget/taskItem.dart';
import 'package:finance/models/task.dart';
import 'package:finance/provider/today_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> with AutomaticKeepAliveClientMixin {
  TodayProvider todayProvider;
  Box<Tasks> taskBox;
  @override
  void initState() {
    super.initState();
    taskBox = Hive.box('tasks');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      todayProvider.initTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    todayProvider = Provider.of<TodayProvider>(context);
    super.build(context);
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 20,
            child: todayProvider.tasks.isEmpty
                ? null
                : Text("${todayProvider.tasks[index].dateTime.toLocal()}"),
          ),
          itemCount: todayProvider.taskLength,
          itemBuilder: (context, index) {
            var task = todayProvider.tasks;
            return todayProvider.tasks.isEmpty
                ? Center(
                    child: Text("You have no task today!"),
                  )
                : TaskItem(
                    title: task[index].title,
                    money: task[index].money,
                  );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
