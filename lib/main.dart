import 'package:bot_toast/bot_toast.dart';
import 'package:finance/controller/baseController.dart';
import 'package:finance/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes/app_routes.dart';
import 'ui/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppDb();
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Finance",
      themeMode: isDarkMode ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: '/',
      initialBinding: BaseController(),
      getPages: AppPages.routes,
      home: HomePage(),
    );
  }
}
