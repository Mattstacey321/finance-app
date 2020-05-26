import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/custom-widget/circleIcon.dart';
import 'package:finance/custom-widget/taskItem.dart';
import 'package:finance/view/checkoutPage.dart';
import 'package:finance/view/profilePage.dart';
import 'package:finance/view/todayPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _widgets = <Widget>[];
  int _selectedIndex = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _widgets = [TodayPage(), CheckoutPage(), ProfilePage()];
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Text("Hello, Matts"),
                Spacer(),
                Row(
                  children: [
                    CircleIcon(
                      onTap: () {},
                      child: FeatherIcons.plus,
                    ),
                    CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                            ),
                        imageUrl: "https://i.picsum.photos/id/22/200/200.jpg")
                  ],
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(40)),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2))]),
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
                      onPressed: () {
                        print(_selectedIndex);
                      },
                    ),
                    GButton(
                      icon: FeatherIcons.check,
                      text: 'Checkout',
                      onPressed: () {},
                    ),
                    GButton(
                      icon: FeatherIcons.user,
                      text: 'Profile',
                      onPressed: () {},
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          )),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _widgets,
      ),
    );
  }
}
