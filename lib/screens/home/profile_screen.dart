import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/models/user_model.dart';
import 'package:nearchat/screens/home/edit_profile_screen.dart';
import 'package:nearchat/screens/start_screen.dart';
import 'package:nearchat/services/auth_service.dart';
import 'package:nearchat/services/profile_service.dart';
import 'package:nearchat/ui/theme/appcolors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  final _firestore = FirebaseFirestore.instance;
  User loggedUser = FirebaseAuth.instance.currentUser!;
  ProfileService profileService = ProfileService();
  ChatUser userData = ChatUser();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('userData');
    setState(() {
      userData = ChatUser.fromJson(jsonDecode(user!));
    });
  }

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.profileBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Hello Appbar",
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.menu, // add custom icons also
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
            currentBackPressTime = now;
            Fluttertoast.showToast(msg: "Press again to exit");
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 20,
              ),
              Container(
                color: Colors.white,
                height: 40.h,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      height: 22.h,
                      width: 22.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppColor.primaryColor, width: 5)),
                      child: CircleAvatar(
                        backgroundColor: AppColor.primaryColor,
                        radius: 50,
                        backgroundImage: userData.avatar != null
                            ? NetworkImage(userData.avatar!)
                            : Image.asset(
                                'assets/img/profile-icon.png',
                                color: Colors.white,
                              ).image,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userData.name ?? "",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          userData.age == "null" ? "" : ', ${userData.age}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, EditProfileScreen.routeName);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColor.primaryColor,
                              AppColor.secondayColor,
                              // AppColor.primaryColorlight,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              size: 15.sp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("About me"),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(userData.discription == "null"
                              ? "wow! empty"
                              : userData.discription ?? ""),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Interests"),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(userData.interests == "null"
                              ? "wow! empty"
                              : userData.interests ?? ""),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          AuthService authService = AuthService();
                          await authService.logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              StartScreen.routeName,
                              (Route<dynamic> route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          backgroundColor: AppColor.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(25), // <-- Radius
                          ),
                        ),
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
