import 'package:bot_toast/bot_toast.dart';
import 'package:finance/models/task.dart';
import 'package:finance/services/map_services.dart';
import 'package:finance/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class TaskController extends GetxController {
  TaskServices _taskServices = TaskServices();
  var location = Map<String, dynamic>();

  var txtLocation = TextEditingController();
  var txtTitle = TextEditingController();
  var txtMoney = TextEditingController();
  var txtTask = TextEditingController();
  var txtDescription = TextEditingController();

  var _checkTitle = false.obs;
  var _checkMoney = false.obs;
  var _checkLocation = false.obs;
  var _isDataEmpty = false.obs;

  bool get isLocationEmpty => _checkLocation.value;
  bool get isDataEmpty => _isDataEmpty.value = !(_checkMoney.value && _checkTitle.value);

  Function get showCreateTaskButton => isDataEmpty
      ? null
      : () {
          addTask();
        };

  void setLocation(String address, Map pickedLocation) {
    this.txtLocation.text = address;
    this.location = pickedLocation;
    print("debug: you set address : $address");
    print("debug: you set location : $pickedLocation");
  }

  Future getLocation() async {
    await MapServices.getCurrentLocation().then((value) {
      this.txtLocation.text = value['address'];
      this.location = value['position'];
    }).catchError((err) => null);
  }

  onTitleChange(String value) {
    value != "" ? _checkTitle.value = true : _checkTitle.value = false;
  }

  onMoneyChange(String value) {
    if (value == "") {
      _checkMoney.value = false;
    } else {
      (int.parse(value) != 0 && int.parse(value) > 0)
          ? _checkMoney.value = true
          : _checkMoney.value = false;
    }
  }

  onLocationChange(String value) {
    return value != "" ? _checkLocation.value = true : _checkLocation.value = false;
  }

  addTask() {
    //print(this.location.toString());
    try {
      var task = Task(
          money: int.parse(txtMoney.text),
          location: this.location,
          title: txtTitle.text,
          dateTime: DateTime.now());

      _taskServices.addTask(task);
      HomeController.to.addTask(task);

      update();
      BotToast.showText(text: "Add success");

      Get.back();
    } catch (e) {
      print(e);
      BotToast.showText(text: "Add fail");
    }
  }

  void clear() {
    txtMoney.text = "0";
    txtTitle.text = "";
    this._isDataEmpty.value = false;
    this._checkLocation.value = false;
    this.txtLocation.clear();
    this.location = {};
  }

  @override
  void onClose() {
    super.onClose();
    clear();
  }
}
