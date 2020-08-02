import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/constraint.dart';
import 'package:finance/controller/homeController.dart';
import 'package:finance/custom-widget/circleIcon.dart';
import 'package:finance/custom-widget/customButton.dart';
import 'package:finance/style.dart';
import 'package:finance/ui/presentTask.dart';
import 'package:finance/ui/profile/profile.dart';
import 'package:finance/util/placeHolder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';

import 'checkout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _widgets = [PresentTask(), Checkout(), Profile()];
  int _selectedIndex = 0;
  PageController _pageController;
  final HomeController h = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      assignId: true,
      id: "task",
      init: HomeController(),
      builder: (model) => Scaffold(
        appBar: PreferredSize(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      await _pageController.animateToPage(2,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                            ),
                        placeholder: (context, url) =>
                            Skeleton.image(height: 40, width: 40, borderRadius: 10),
                        imageUrl:
                            "https://i.picsum.photos/id/774/200/200.jpg?hmac=kHZuEL0Tzh_9wUk4BnU9zxodilE2mGBdAAor2hKpA_w"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, Matts",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text("${DateFormat.yMEd().format(DateTime.now().toLocal())}")
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                    height: 40,
                    width: 40,
                    icon: FeatherIcons.plus,
                    onPress: () {
                      Get.isBottomSheetOpen ? model.clear() : model.showAddTask();
                    },
                    iconColor: Colors.blue,
                    tooltip: "Create task",
                    radius: 10,
                  )
                ],
              ),
            ),
            preferredSize: Size.fromHeight(AppConstraint.appBarHeight)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // Tong tien here
        floatingActionButton: Visibility(
          visible: _selectedIndex == 0 ? true : false,
          child: CircleIcon(
            isCircle: false,
            onTap: () {},
            child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                decoration:
                    BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
                child:
                    Text("${model.totalMoney} đ", style: AppStyle.homeMoneyTitleFloatingButton)),
          ),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(

                // boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2))]

                ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: Duration(milliseconds: 500),
                    tabBackgroundColor: Colors.grey[800],
                    tabs: [
                      GButton(
                        icon: FeatherIcons.activity,
                        text: 'Today',
                      ),
                      GButton(
                        icon: FeatherIcons.check,
                        text: 'Checkout',
                      ),
                      GButton(
                        icon: FeatherIcons.user,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                        _pageController.animateToPage(_selectedIndex,
                            duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
                      });
                    }),
              ),
            )),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _widgets,
        ),
      ),
    );
  }
}
