import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:finance/constraint.dart';
import 'package:finance/controller/editProfileController.dart';
import 'package:finance/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  double _avatarHeight = 120;
  double _avatarWidth = 120;
  TextStyle editTextTitle = TextStyle(fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  CircleIcon(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(FeatherIcons.arrowLeft)),
                  SizedBox(width: 10),
                  Text("Edit Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            preferredSize: Size.fromHeight(50)),
        body: GetBuilder<EditProfileController>(
          init: EditProfileController(),
          builder: (_) => Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: AppConstraint.demoAvatar,
                        height: _avatarHeight,
                        width: _avatarWidth,
                        placeholder: (context, url) => Container(
                          height: _avatarHeight,
                          width: _avatarWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppConstraint.circleBorder),
                              color: Colors.grey),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          height: _avatarHeight,
                          width: _avatarWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: Colors.grey,
                              image: DecorationImage(image: imageProvider, fit: BoxFit.contain)),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 2,
                          child: CustomButton(
                              onPress: () {},
                              tooltip: "",
                              iconColor: Colors.white,
                              isClickable: false,
                              icon: FeatherIcons.edit2,
                              height: 40,
                              width: 40,
                              radius: 1000)),
                      Positioned.fill(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(AppConstraint.circleBorder),
                                splashColor: Colors.grey.withOpacity(0.2),
                                onTap: () {
                                  Get.bottomSheet(
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                              leading: Icon(FeatherIcons.image),
                                              title: Text("Change profile"),
                                              onTap: () {})
                                        ],
                                      ),
                                      useRootNavigator: true,
                                      backgroundColor: Color(0xff424242));
                                },
                              )))
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nick name",
                          style: editTextTitle,
                        ),
                        SizedBox(height:10),
                        TextField(
                          controller: _.usernameController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 20),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              focusedErrorBorder:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Username",
                              hintStyle: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full name",
                          style: editTextTitle,
                        ),
                        SizedBox(height:10),
                        TextField(
                          controller: _.fullNameController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 20),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              focusedErrorBorder:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Full name",
                              hintStyle: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: editTextTitle,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _.emailController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 20),
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              focusedErrorBorder:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.transparent)),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              hintText: "Email",
                              hintStyle: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonTheme(
                        height: 50,
                        minWidth: Get.width - (Get.width * 0.3),
                        child: RaisedButton(
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppConstraint.rounedBorder)),
                          onPressed: () {},
                          child: Text("Save"),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
