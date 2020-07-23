import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/controller/profileController.dart';
import 'package:finance/custom-widget/customButton.dart';
import 'package:finance/custom-widget/customSetting.dart';
import 'package:finance/custom-widget/statistics_animation.dart';
import 'package:finance/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var list = [
    {"title": "Today", "money": 200000},
    {"title": "This week", "money": 2560000},
    {"title": "This month", "money": 5600000}
  ];
  var listMenu = ["Profile Information", "Dark mode", "Log out"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileController>(
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
                              style:
                                  TextStyle(color: Colors.orange[100], fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ),
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
                    onTap: () {},
                    childs: [Spacer(), Icon(FeatherIcons.chevronRight)],
                  ),
                  Divider(thickness: 1),
                  CustomSetting(
                    title: "Language",
                    onTap: () {
                      _.changeLanguage();
                    },
                    childs: [Spacer(), Text("English")],
                  ),
                  Divider(thickness: 1),
                  CustomSetting(
                    title: "Dark mode",
                    onTap: () {
                      _.switchTheme();
                    },
                    childs: [Spacer(), Obx(() => Text("${_.isDarkMode ? "Light" : "Dark"}"))],
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: Get.width,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CustomButton(
                          height: 50,
                          width: 140,
                          onPress: () {},
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
    ));
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
