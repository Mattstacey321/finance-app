import 'package:bot_toast/bot_toast.dart';
import 'package:finance/controller/baseController.dart';
import 'package:finance/controller/homeController.dart';
import 'package:finance/controller/profileController.dart';
import 'package:finance/controller/themeController.dart';
import 'package:finance/provider/today_provider.dart';
import 'package:finance/services/hive_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/home.dart';
import 'ui/login/login.dart';
import 'ui/profile.dart';
import 'ui/sign_up/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp(
    isDarkMode: prefs.getBool("darkMode") ?? false,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  MyApp({this.isDarkMode});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TodayProvider())],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Finance",
        themeMode: isDarkMode ? ThemeMode.light : ThemeMode.dark,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: '/',
        initialBinding: BaseController(),
        getPages: [
          GetPage(name: '/login', page: () => Login(), transition: Transition.fade),
          GetPage(
              name: '/signup', page: () => SignUp(), transition: Transition.rightToLeftWithFade),
          GetPage(
              name: '/home',
              page: () => HomePage(),
              transition: Transition.native,
              binding: BaseController()),
          GetPage(name: '/profile', page: () => Profile(), binding: BaseController()),
        ],
        home: HomePage(),
      ),
    );
  }
}
