import 'package:bot_toast/bot_toast.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/color.dart';
import 'package:finance/controller/home_controller.dart';
import 'package:finance/controller/profile_controller.dart';
import 'package:finance/theme/style.dart';
import 'package:finance/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/profile_widgets.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (_) => Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: Get.width,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1, blurRadius: 15)
                  ],
                  gradient: AppColor.gradientColor.whoseProduct),
              child: Stack(
                children: [
                  Positioned(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Your balance",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "18000000 đ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                          height: 40,
                          width: 100,
                          onPress: () {
                            Get.bottomSheet(ManageBalance(),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: AppStyle.bottomSheetBorder),
                                useRootNavigator: true,
                                isScrollControlled: true);
                          },
                          childs: [
                            Text("Manage",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                overflow: TextOverflow.ellipsis)
                          ],
                          opacity: 1,
                          tooltip: "Manage",
                          iconColor: Colors.white,
                          backgroundColor: Colors.orange[600].withOpacity(0.8),
                          showElevation: true,
                          icon: Icons.settings),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
                height: 50,
                width: Get.width,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GetBuilder<HomeController>(
                  id: "task", // listen value change when this GetBuilder has that id change
                  builder: (h) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      buildUserSummary(title: "Today", money: h.totalMoney),
                      SizedBox(width: 40),
                      buildUserSummary(title: "This week", money: 0),
                      SizedBox(width: 40),
                      buildUserSummary(title: "This month", money: 0)
                    ],
                  ),
                )),
            SizedBox(height: 20),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomSetting(
                    title: "Profile Information",
                    icon: FeatherIcons.user,
                    iconColor: Theme.of(context).iconTheme.color,
                    onTap: () {
                      print("profile");
                      Get.toNamed('/editprofile');
                    },
                    childs: [Spacer(), Icon(FeatherIcons.chevronRight)],
                  ),
                  SizedBox(height: 20),
                  CustomSetting(
                    title: "Language",
                    icon: FeatherIcons.globe,
                    iconColor: Theme.of(context).iconTheme.color,
                    onTap: () {
                      _.switchLanguage();
                      print("language");
                    },
                    childs: [Spacer(), Text("English")],
                  ),
                  SizedBox(height: 20),
                  CustomSetting(
                    title: "Dark mode",
                    icon: FeatherIcons.moon,
                    iconColor: Theme.of(context).iconTheme.color,
                    onTap: () => null,
                    isClickable: false,
                    childs: [
                      Spacer(),
                      AbsorbPointer(
                          absorbing: false,
                          child: ThemeSwitcher(
                            onTap: () {
                              _.switchTheme();
                            },
                            isDarkMode: _.isDarkMode,
                          ))
                      //Obx(() => Text("${_.isDarkMode ? "Light" : "Dark"}"))
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomSetting(
                    title: "Sync data",
                    icon: FeatherIcons.refreshCw,
                    iconColor: Theme.of(context).iconTheme.color,
                    onTap: () {
                      BotToast.showText(text: "Sync data ...");
                    },
                    childs: [Spacer(), Text("Last modified 31/7/2020")],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        width: Get.width,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          CustomButton(
                              height: 50,
                              width: 140,
                              onPress: () {
                                _.logout();
                              },
                              tooltip: "Log out",
                              iconColor: Colors.red,
                              childs: [Text("Log out")],
                              icon: FeatherIcons.logOut),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ))
            //Text("Your monthly money", style: AppStyle.titleMoneyProfile),
          ],
        ),
      ),
    );
  }
}

Widget buildUserSummary({String title, int money}) {
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text(
      "$title",
      style: TextStyle(fontSize: 18),
    ),
    SizedBox(height: 5),
    Text("$money đ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
  ]);
}
