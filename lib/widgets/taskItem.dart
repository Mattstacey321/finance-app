import 'dart:async';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/services/map_services.dart';
import 'package:finance/util/checkTime.dart';
import 'package:finance/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskItem extends StatefulWidget {
  final int index;
  final String title;
  final int money;
  final Map location;
  final String time;
  final String type;
  final Function onTapped;
  final Function onTapMore;
  TaskItem({this.title, this.index, this.onTapped,this.onTapMore, this.type, this.time, this.money, this.location});
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  StreamController _timeController;
  @override
  void initState() {
    _timeController = StreamController();
    updateTime();
    super.initState();
  }

  updateTime() {
    return _timeController.add(toNow(DateTime.parse(widget.time)));
  } 

  onTapMore(){
    
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () => widget.onTapped(),
      child: Container(
        width: Get.width,
        height: 150,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                CustomButton(
                    height: 30,
                    width: 30,
                    onPress: ()=> onTapMore(),
                    tooltip: "More",
                    iconColor: Colors.white,
                    opacity: 0,
                    icon: FeatherIcons.moreHorizontal)
              ],
            ),
            // date time
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      FeatherIcons.mapPin,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    FutureBuilder<String>(
                      future: Future(() async {
                        //print(widget.location['latitude']);
                        // print(widget.location['longitude']);
                        return await MapServices.getAddressLocation(
                            latitude: widget.location['latitude'],
                            longitude: widget.location['longitude']);
                      }),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Flexible(
                              child: Text(
                            "Waiting",
                            overflow: TextOverflow.ellipsis,
                          ));
                        }
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Flexible(
                            child: Text(
                              "Has error",
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        } else
                          return Flexible(
                              child: Text(
                            snapshot.data,
                            overflow: TextOverflow.ellipsis,
                          ));
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      FeatherIcons.clock,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    StreamBuilder(
                      stream: _timeController.stream,
                      builder: (context, snapshot) {
                        // print('Has error: ${snapshot.hasError}');
                        //  print('Has data: ${snapshot.hasData}');
                        // print('Snapshot Data ${snapshot.data}');
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text("Waiting");
                        } else {
                          return Text(snapshot.data);
                        }
                      },
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.hash,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${widget.money} đ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    CustomButton(
                      height: 35,
                      width: 100,
                      onPress: () {},
                      isClickable: false,
                      tooltip: "",
                      iconColor: Colors.orange,
                      icon: FeatherIcons.pieChart,
                      childs: [
                        Text(
                          widget.type,
                          style: TextStyle(
                              color: Colors.orange[900], fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
