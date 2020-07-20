import 'package:bot_toast/bot_toast.dart';
import 'package:finance/provider/today_provider.dart';
import 'package:finance/services/hive_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'ui/home.dart';
import 'ui/login/login.dart';
import 'ui/profile.dart';
import 'ui/sign_up/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        builder: BotToastInit(), //1. call BotToastInit
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: '/',
        getPages: [
          GetPage(name: '/login', page: () => Login(), transition: Transition.fade),
          GetPage(
              name: '/signup', page: () => SignUp(), transition: Transition.rightToLeftWithFade),
          GetPage(name: '/home', page: () => HomePage(), transition: Transition.native),
          GetPage(name: '/profile', page: () => Profile()),
        ],
        home: HomePage(),
      ),
    );
  }
}
