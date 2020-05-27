import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/custom-widget/circleIcon.dart';
import 'package:finance/models/task.dart';
import 'package:finance/provider/today_provider.dart';
import 'package:finance/view/checkoutPage.dart';
import 'package:finance/view/profilePage.dart';
import 'package:finance/view/todayPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _widgets = <Widget>[];
  int _selectedIndex = 0;
  PageController _pageController;
  TodayProvider todayProvider;
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
    //var screenSize = MediaQuery.of(context).size;
    todayProvider = Provider.of<TodayProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
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
                Row(
                  children: [
                    CircleIcon(
                      onTap: () {
                        // call add new task
                        showAddTask(context);
                      },
                      child: Icon(FeatherIcons.plus),
                    ),
                    CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                            ),
                        imageUrl: "https://i.picsum.photos/id/22/200/200.jpg")
                  ],
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(50)),
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
              child: Text(
                "${todayProvider.totalMoney} đ",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ),
      ),
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

showAddTask(BuildContext context) {
  var txtTitle = TextEditingController();
  var txtMoney = TextEditingController();
  TodayProvider todayProvider;

  var screenSize = MediaQuery.of(context).size;
  return showDialog(
    context: context,
    barrierDismissible: true,
    useRootNavigator: true,
    builder: (context) {
      todayProvider = Provider.of<TodayProvider>(context);
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        /* actions: [
          RaisedButton(onPressed: (){},child: Text("Close"),),
          RaisedButton(onPressed: (){},child: Text("Create"),)
        ],*/
        child: Container(
          height: 200,
          width: screenSize.width,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 50,
                width: screenSize.width,
                child: TextField(
                  controller: txtTitle,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      hintText: "Title",
                      hintStyle: TextStyle(fontSize: 15)),
                ),
              ),
              Container(
                height: 50,
                width: screenSize.width,
                child: TextField(
                  controller: txtMoney,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    new BlacklistingTextInputFormatter(new RegExp('[^[a-zA-Z ]]')),
                  ],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      hintText: "Money",
                      hintStyle: TextStyle(fontSize: 15)),
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close"),
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    onPressed: () async {
                      await todayProvider.addTask(Task(
                          dateTime: DateTime.now(),
                          money: int.parse(txtMoney.text),
                          title: txtTitle.text.trim()));
                      Navigator.pop(context);
                    },
                    child: Text("Create"),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
