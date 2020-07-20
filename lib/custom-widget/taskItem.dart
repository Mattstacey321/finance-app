import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/custom-widget/customButton.dart';
import 'package:finance/util/checkTime.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskItem extends StatefulWidget {
  final String title;
  final int money;
  final String location;
  final String time;
  final String type;

  TaskItem({this.title,this.type, this.time, this.money, this.location});
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onPress: () {},
                  tooltip: "More",
                  iconColor: Colors.black,
                  opacity: 0,
                  icon: FeatherIcons.moreHorizontal)
            ],
          ),
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
                  Text(widget.location)
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
                  Text(toNow(DateTime.parse(widget.time)))
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
                    onPress: (){},
                    isClickable: false, 
                    tooltip: "", 
                    iconColor: Colors.orange, 
                    icon: FeatherIcons.pieChart,
                    childs: [
                      Text("Eat",style: TextStyle(color:Colors.orange[900],fontSize:16,fontWeight: FontWeight.bold),)
                    ],
                    
                    )
                  
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
