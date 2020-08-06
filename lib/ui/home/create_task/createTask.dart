import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/controller/taskController.dart';
import 'package:finance/ui/home/create_task/widgets/addTaskType.dart';
import 'package:finance/ui/map_view/map.dart';
import 'package:finance/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../theme/style.dart';

class CreateTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
      init: TaskController(),
      builder: (_) => SingleChildScrollView(
        child: Material(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  child: Stack(
                    children: [
                      CustomButton(
                          height: 30,
                          width: 30,
                          onPress: () {
                            Get.back();
                          },
                          tooltip: "Close",
                          radius: 1000,
                          iconColor: Colors.grey,
                          icon: FeatherIcons.x),
                      Positioned.fill(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Create a task",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              )))
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text("Task title", style: AppStyle.titleCreateTaskBottomSheet),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  width: Get.width,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _.txtTitle,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      _.onTitleChange(value);
                    },
                    maxLines: 2,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: "Your title here",
                        suffixIcon: CircleIcon(
                            onTap: () {
                              _.txtTitle.clear();
                            },
                            child: Icon(FeatherIcons.x)),
                        hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
                SizedBox(height: 10),
                Text("Money", style: AppStyle.titleCreateTaskBottomSheet),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  width: Get.width,
                  child: TextField(
                    controller: _.txtMoney,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(new RegExp('[^[a-zA-Z ]]')),
                    ],
                    style: TextStyle(fontSize: 20),
                    onChanged: (value) {
                      _.onMoneyChange(value);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        focusedErrorBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Your money here",
                        suffixIcon: CircleIcon(
                            onTap: () {
                              _.txtMoney.clear();
                            },
                            child: Icon(FeatherIcons.x)),
                        prefixIcon: CircleIcon(onTap: null, child: Icon(Icons.attach_money)),
                        hintStyle: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Location", style: AppStyle.titleCreateTaskBottomSheet),
                    Spacer(),
                    Obx(() => InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: !_.isLocationEmpty
                              ? null
                              : () {
                                  Get.to(
                                      MapView(
                                        latitude: _.location['latitude'],
                                        longitude: _.location['longitude'],
                                      ),
                                      transition: Transition.upToDown,
                                      opaque: false);
                                },
                          child: Container(
                            height: 25,
                            width: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    !_.isLocationEmpty ? Colors.grey : Colors.red.withOpacity(0.2)),
                            child: Text("Edit"),
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 60,
                  width: Get.width,
                  child: TextField(
                    controller: _.txtLocation,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    onChanged: (value) {
                      _.onLocationChange(value);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        focusedErrorBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        prefixIcon: CircleIcon(
                            onTap: () async {
                              await _.getLocation();
                            },
                            tooltip: "Get location",
                            child: Icon(FeatherIcons.mapPin)),
                        hintText: "Your location here",
                        hintStyle: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(height: 10),
                Text("Task Type", style: AppStyle.titleCreateTaskBottomSheet),
                SizedBox(height: 10),
                AddTaskType(
                  onTap: () {},
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text("Description", style: AppStyle.titleCreateTaskBottomSheet,),
                    SizedBox(width:10),
                    Text("(Optional)",style: AppStyle.titleSubCreateTaskBottomSheet,)
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  
                  width: Get.width,
                  child: TextField(
                    controller: _.txtDescription,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    maxLines: 5,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        focusedErrorBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.transparent)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        //prefixIcon: Icon(FeatherIcons.edit2),
                        hintStyle: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(height: 30),
                Obx(() => Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonTheme(
                        height: 50,
                        minWidth: 200,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: Colors.indigo,
                          textColor: Colors.white,
                          onPressed: _.showCreateTaskButton,
                          child: Text("Create Task"),
                        ),
                      ),
                    )),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
