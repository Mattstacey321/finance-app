import 'package:finance/controller/home_controller.dart';
import 'package:finance/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresentTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (model) {
        var tasks = model.tasks;
        return Scaffold(
          body: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: CustomAnimation.slideUp(
              delayed: 400,
              show: true,
              child: tasks.isEmpty
                  ? Center(
                      child: Text("You have no task today!"),
                    )
                  : Column(
                      children: [
                        Flexible(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              return TaskItem(
                                title: tasks[index].title,
                                money: tasks[index].money,
                                location: tasks[index].location,
                                time: tasks[index].dateTimeAsString,
                                onTapped: () {},
                                type: "Eat",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
/*
class PresentTask extends StatefulWidget {
  @override
  _PresentTaskState createState() => _PresentTaskState();
}

class _PresentTaskState extends State<PresentTask> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return 
  }

  @override
  bool get wantKeepAlive => true;
}
*/
