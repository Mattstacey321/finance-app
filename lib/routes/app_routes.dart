import 'package:finance/controller/baseController.dart';
import 'package:finance/routes/routes.dart';
import 'package:get/get.dart';

import '../ui/home.dart';
import '../ui/login/login.dart';
import '../ui/profile/profile.dart';
import '../ui/sign_up/signUp.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => Login(), transition: Transition.fade),
    GetPage(name: Routes.SIGNUP, page: () => SignUp(), transition: Transition.rightToLeftWithFade),
    GetPage(
        name: Routes.HOME,
        page: () => HomePage(),
        transition: Transition.native,
        binding: BaseController()),
    GetPage(name: Routes.PROFILE, page: () => Profile(), binding: BaseController()),
  ];
}
