import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/custom-widget/FaSlideUp.dart';
import 'package:finance/custom-widget/taskItem.dart';
import 'package:finance/provider/today_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  CalendarController _calendarController;
  TodayProvider todayProvider;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      todayProvider.countTask(DateTime.now());
    });
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    todayProvider = Provider.of<TodayProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _calendarController.setSelectedDay(DateTime.now(), animate: true, isProgrammatic: true);
        },
        child: Icon(FeatherIcons.bookmark),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaSlideAnimation.slideUp(
              delayed: 200,
              show: true,
              child: Selector<TodayProvider, List>(
                selector: (_, data) => data.currentTask,
                builder: (context, value, child) => TableCalendar(
                  initialCalendarFormat: CalendarFormat.week,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                  ),
                  calendarController: _calendarController,
                  builders: CalendarBuilders(
                    dayBuilder: (context, date, events) {
                       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        todayProvider.countTask(date);
                        
                      });
                      return Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        child: Text("${date.day}"),
                      );
                    },
                    selectedDayBuilder: (context, date, events) {
                      print("u click $date");
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        //todayProvider.countTask(date);
                        todayProvider.getTaskDetail(date);
                      });
                      return buildDay(date, value.length);
                    },
                    todayDayBuilder: (context, date, events) {
                      // int tasks = 0;
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        todayProvider.countTask(date);
                      });
                      return buildDay(date, value.length);
                    },
                  ),
                ),
              ),
            ),
            Consumer<TodayProvider>(
              builder: (context, value, child) => Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: value.currentTask.isEmpty
                      ? Center(
                          child: Text("You have no task today!"),
                        )
                      : FaSlideAnimation.slideUp(
                          delayed: 200,
                          show: true,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      "${DateFormat('h:mm a').format(value.tasks[index].dateTime.toLocal())}",
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            itemCount: value.totalCurrentTask,
                            itemBuilder: (context, index) {
                              var task = value.currentTask;
                              return TaskItem(
                                title: task[index].title,
                                money: task[index].money,
                              );
                            },
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildDay(DateTime date, int value) {
  return Container(
    width: 40,
    height: 40,
    margin: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.indigo),
    child: Stack(
      children: [
        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  date.day.toString(),
                  style: TextStyle(color: Colors.white),
                ))),
        value > 0
            ? Positioned(
                right: -2,
                bottom: -1,
                child: Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.amber,
                    ),
                    child: Text("$value")))
            : Container()
      ],
    ),
  );
}
