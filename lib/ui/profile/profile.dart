import 'package:bot_toast/bot_toast.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/controller/homeController.dart';
import 'package:finance/controller/profileController.dart';
import 'package:finance/custom-widget/customButton.dart';
import 'package:finance/custom-widget/customSetting.dart';
import 'package:finance/custom-widget/themeSwitcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {

  static var list = [
    {"title": "Today", "money": HomeController.to.totalMoney},
    {"title": "This week", "money": 2560000},
    {"title": "This month", "money": 5600000}
  ];

  @override
  Widget build(BuildContext context) {
    
    var listMenu = ["Profile Information", "Dark mode", "Log out"];

    return GetBuilder<ProfileController>(
      
      builder: (_) => Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: Get.width,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffF2994A), Color(0xffF2C94C)])),
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
                              "18000000 đ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Your balance",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ),
                  SizedBox(height: 10),
                  Positioned(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                        height: 40,
                        width: 100,
                        onPress: () {},
                        childs: [
                          Text("Manage",
                              style:
                                  TextStyle(color: Colors.orange[900], fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis)
                        ],
                        tooltip: "Manage",
                        iconColor: Colors.orange[900],
                        icon: Icons.settings),
                  ))
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: Get.width,
              alignment: Alignment.center,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: VerticalDivider(
                    thickness: 2,
                  ),
                ),
                itemCount: 3,
                itemBuilder: (context, index) =>
                    buildUserSummary(title: list[index]['title'], money: list[index]['money']),
              ),
            ),
            SizedBox(height: 10),
            Flexible(
                child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Divider(thickness: 1),
                  CustomSetting(
                    title: "Profile Information",
                    onTap: () {
                      print("profile");
                    },
                    childs: [Spacer(), Icon(FeatherIcons.chevronRight)],
                  ),
                  Divider(thickness: 1),
                  CustomSetting(
                    title: "Language",
                    onTap: () {
                      _.switchLanguage();
                      print("language");
                    },
                    childs: [Spacer(), Text("English")],
                  ),
                  Divider(thickness: 1),
                  CustomSetting(
                    title: "Dark mode",
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
                  Divider(thickness: 1),
                  CustomSetting(
                    title: "Sync data",
                    onTap: () {
                      BotToast.showText(text: "Sync data ...");
                    },
                    childs: [Spacer(), Text("Last modified 31/7/2020")],
                  ),
                  Spacer(),
                  Container(
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
/*
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static HomeController h = Get.put(HomeController());
  var list = [
    {"title": "Today", "money": h.totalMoney},
    {"title": "This week", "money": 2560000},
    {"title": "This month", "money": 5600000}
  ];
  var listMenu = ["Profile Information", "Dark mode", "Log out"];

  @override
  Widget build(BuildContext context) {
    return 
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
}*/
