import 'package:finance/controller/homeController.dart';
import 'package:finance/controller/profileController.dart';
import 'package:finance/controller/themeController.dart';
import 'package:get/get.dart';

class BaseController implements Bindings {
  @override
  void dependencies() {
    Get.put<ThemeController>(ThemeController());
    //Get.lazyPut(() => HomeController());
    //Get.lazyPut(() => ProfileController());
    Get.put<HomeController>(HomeController(),permanent: true);
    Get.put<ProfileController>(ProfileController());
    
  }
}
