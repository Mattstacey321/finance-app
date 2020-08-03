import 'package:bot_toast/bot_toast.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/custom-widget/addTaskType.dart';
import 'package:finance/custom-widget/circleIcon.dart';
import 'package:finance/custom-widget/customButton.dart';
import 'package:finance/models/task.dart';
import 'package:finance/services/map_services.dart';
import 'package:finance/services/task_services.dart';
import 'package:finance/style.dart';
import 'package:finance/ui/map_view/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TaskServices _taskServices = TaskServices();
  static HomeController get to => Get.find();
  var location = Map<String, dynamic>();
  var _txtLocation = TextEditingController();
  var _txtTitle = TextEditingController();
  var _txtMoney = TextEditingController();
  var _txtTask = TextEditingController();
  var _checkTitle = false.obs;
  var _checkMoney = false.obs;
  var _checkLocation = false.obs;
  var _isDataEmpty = false.obs;
  var _tasks = <Task>[];
  var _currentTasks = [];
  var _totalMoney = 0.obs;

  int get totalMoney {
    var totalMoney = 0;
    for (var item in tasks) {
      totalMoney += item.money;
    }
    return _totalMoney.value = totalMoney;
  }

  int get countCurrentTask => _currentTasks.length;
  int get countTodayTask => _tasks.length;
  List<Task> get tasks => _tasks;
  List get currentTask => _currentTasks;
  bool get isLocationEmpty => _checkLocation.value;
  bool get isDataEmpty => _isDataEmpty.value = !(_checkMoney.value && _checkTitle.value);
  @override
  onInit() async {
    initTask();

    super.onInit();
  }

  void initTask() {
    _tasks.addAll(_taskServices.initTask());
    _currentTasks.addAll(_taskServices.initTask());
    update();
  }

  setLocation(String address, Map pickedLocation) {
    this._txtLocation.text = address;
    this.location = pickedLocation;
    print("debug: you set address : $address");
    print("debug: you set location : $pickedLocation");
  }

  getCurrentTask(DateTime currentTime) {
    _currentTasks = [];
    print("hello ${_taskServices.getTaskByDate(currentTime)}");
    _currentTasks.addAll(_taskServices.getTaskByDate(currentTime) ?? []);
    update();
  }

  removeTask({int index, String time}) {
    Get.defaultDialog(
        title: "Delete item ?",
        content: Container(
          height: 50,
          width: Get.width,
          alignment: Alignment.center,
          child: Text("Do you want to log out ?"),
        ),
        radius: 10,
        confirm: FlatButton(
            onPressed: () async {
              if (await _taskServices.removeTask(index, time)) {
                _totalMoney.value -= _tasks[index].money;
                _tasks.removeAt(index);
                _currentTasks.removeAt(index);

                update();
                BotToast.showText(text: "Delete success");
                Get.back();
              } else {
                BotToast.showText(text: "Delete fail");
              }
            },
            child: Text("Delete")),
        cancel: FlatButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel")));
  }

  showAddTask() {
    _txtMoney.text = "0";
    _txtTitle.text = "";
    this._isDataEmpty.value = false;
    this._checkLocation.value = false;
    this._txtLocation.clear();
    this.location = {};
    return Get.bottomSheet(
      SingleChildScrollView(
        child: Material(
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
                    controller: _txtTitle,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      value != "" ? _checkTitle.value = true : _checkTitle.value = false;
                    },
                    maxLines: 2,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: "Your title here",
                        suffixIcon: CircleIcon(
                            onTap: () {
                              _txtTitle.clear();
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
                    controller: _txtMoney,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      new FilteringTextInputFormatter.deny(new RegExp('[^[a-zA-Z ]]')),
                    ],
                    style: TextStyle(fontSize: 20),
                    onChanged: (value) {
                      if (value == "") {
                        _checkMoney.value = false;
                      } else {
                        (int.parse(value) != 0 && int.parse(value) > 0)
                            ? _checkMoney.value = true
                            : _checkMoney.value = false;
                      }
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
                              _txtMoney.clear();
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
                          onTap: !this.isLocationEmpty
                              ? null
                              : () {
                                  Get.to(
                                      MapView(
                                        latitude: location['latitude'],
                                        longitude: location['longitude'],
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
                                color: Colors.red.withOpacity(0.2)),
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
                    controller: _txtLocation,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    onChanged: (value) {
                      print("location value $value");
                      return value.isNotEmpty
                          ? _checkLocation.value = true
                          : _checkLocation.value = false;
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
                              await MapServices.getCurrentLocation().then((value) {
                                this._txtLocation.text = value['address'];
                                this.location = value['position'];
                              }).catchError((err) => null);
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
                          onPressed: isDataEmpty
                              ? null
                              : () {
                                  addTask();
                                },
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
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      useRootNavigator: true,
      ignoreSafeArea: true,
      isScrollControlled: true,
    );
  }

  addTask() {
    print(this.location.toString());
    try {
      var task = Task(
          money: int.parse(_txtMoney.text),
          location: this.location,
          title: _txtTitle.text,
          dateTime: DateTime.now());

      _taskServices.addTask(task);
      _tasks.add(task);
      _currentTasks.add(task);

      update();

      BotToast.showText(text: "Add success");

      Get.back();
    } catch (e) {
      print(e);
      BotToast.showText(text: "Add fail");
    }
  }

  void clear() {
    this._txtMoney.text = "0";
    this._txtTitle.text = "";
    this._txtLocation.clear();
    this.location = {};
  }
}
