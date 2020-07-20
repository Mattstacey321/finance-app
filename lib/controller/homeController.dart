import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/custom-widget/circleIcon.dart';
import 'package:finance/custom-widget/customButton.dart';
import 'package:finance/services/task_services.dart';
import 'package:finance/style.dart';
import 'package:finance/ui/map_view/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TaskServices _taskServices = TaskServices();
  var location = Position();
  var _txtLocation = TextEditingController();
  var _tasks = [];
  var _currentTasks = [];
  var _totalMoney = 0.obs;

  int get totalMoney => _totalMoney.value;
  int get totalCurrentTask => _currentTasks.length;
  List get tasks => _tasks;
  List get currentTask => _currentTasks;

  @override
  onInit() async {
    _tasks.addAll(_taskServices.initTask());
    _currentTasks.addAll(_taskServices.initTask());
    super.onInit();
  }

  Future getLocation() async {
    Position position =
        await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator().placemarkFromPosition(position);
    String yourLocation = placemark[0].subThoroughfare +
        ' ,' +
        placemark[0].thoroughfare +
        ' ,' +
        placemark[0].subAdministrativeArea;
    _txtLocation.text = yourLocation;
    this.location = position;
  }

  setLocation(String location) {
    this._txtLocation.text = location;
    print("debug: you set location : $location");
  }

  getCurrentTask(DateTime currentTime) {
    _currentTasks = [];
    _currentTasks.addAll(_taskServices.getTaskByDate(currentTime) ?? []);
    update();
  }

  showAddTask() {
    var txtTitle = TextEditingController();
    var txtMoney = TextEditingController();
    var txtTask = TextEditingController();
    return Get.bottomSheet(
        SafeArea(
          child: SingleChildScrollView(
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
                    height: 50,
                    width: Get.width,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: txtTitle,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          hintText: "Your title here",
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
                      controller: txtMoney,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        new BlacklistingTextInputFormatter(new RegExp('[^[a-zA-Z ]]')),
                      ],
                      style: TextStyle(fontSize: 20, color: Colors.black),
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
                          hintStyle: TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Location", style: AppStyle.titleCreateTaskBottomSheet),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: Get.width,
                    child: TextField(
                      controller: _txtLocation,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20, color: Colors.black),
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
                                await getLocation().whenComplete(() => Get.to(
                                    Map(
                                      position: this.location,
                                    ),
                                    transition: Transition.upToDown,
                                    opaque: false));
                              },
                              child: Icon(FeatherIcons.mapPin)),
                          hintText: "Your location here",
                          hintStyle: TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Task Type", style: AppStyle.titleCreateTaskBottomSheet),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: Get.width,
                    child: TextField(
                      controller: txtTask,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20, color: Colors.black),
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
                          hintText: "Select task",
                          hintStyle: TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonTheme(
                      height: 50,
                      minWidth: 200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        color: Colors.indigo,
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Text("Create Task"),
                      ),
                    ),
                  )
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
        backgroundColor: Colors.white);

  
  }
}
