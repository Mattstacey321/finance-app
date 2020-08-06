import 'package:finance/controller/home_controller.dart';
import 'package:finance/controller/profile_controller.dart';
import 'package:finance/controller/theme_controller.dart';
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
