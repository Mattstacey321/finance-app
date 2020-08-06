import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var fullNameController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    usernameController.text = "Mattstacey";
    fullNameController.text = "Hoang Nguyen";
    emailController.text = "demo_mail@gmail.com";
  }
}
