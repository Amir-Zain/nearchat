import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/models/user_model.dart';
import 'package:nearchat/screens/home/home_screen.dart';
import 'package:nearchat/screens/home/profile_screen.dart';
import 'package:nearchat/services/profile_service.dart';
import 'package:nearchat/ui/textfield.dart';
import 'package:nearchat/ui/theme/appcolors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'edit_profile_screen';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
  File? avatar;

  TextEditingController ageController = TextEditingController(text: "");
  TextEditingController discriptionController = TextEditingController(text: "");
  TextEditingController interestsController = TextEditingController(text: "");
  @override
  void initState() {
    getData();
    super.initState();
  }

  checkValues() async {
    String age = ageController.text.trim();
    String discription = discriptionController.text.trim();
    String interests = interestsController.text.trim();
    userData.age = age;
    userData.discription = discription;
    userData.interests = interests;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.textColor = Colors.white;
    EasyLoading.instance.backgroundColor = Colors.white;
    EasyLoading.instance.indicatorColor = AppColor.primaryColor;
    EasyLoading.show();
    await profileService.updateProfile(userData, avatar);
    EasyLoading.dismiss();
    if (!mounted) return;
    Navigator.pushNamed(context, HomeScreen.routeName, arguments: {"index": 2});
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('userData');
    userData = ChatUser.fromJson(jsonDecode(user!));
    // avatar = await profileService.urlToFile(userData.avatar!);
    ageController.text = userData.age ?? "";
    discriptionController.text = userData.discription ?? "";
    interestsController.text = userData.interests ?? "";
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.profileBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                checkValues();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        shape: const Border(
            bottom: BorderSide(
          color: Colors.grey,
        )),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back, // add custom icons also
            color: AppColor.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 20,
            ),
            Container(
              color: Colors.white,
              height: 32.h,
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(
                    height: 22.h,
                    width: 22.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 22.h,
                          width: 22.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: AppColor.primaryColor, width: 5)),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage: avatar != null
                                ? FileImage(avatar!)
                                : Image.asset(
                                    'assets/img/profile-icon.png',
                                    color: Colors.white,
                                  ).image,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () async {
                              dynamic image =
                                  await profileService.selectImage();
                              if (image != null) {
                                setState(() {
                                  avatar = image;
                                });
                              }
                            },
                            child: Container(
                              // alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              height: 50,
                              width: 50,
                              child: const Icon(Icons.edit),
                            ),
                          ),
                        )
                      ],
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
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
                      const Text("Age"),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFieldCustom(
                        inputType: TextInputType.number,
                        maxLine: 1,
                        controller: ageController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("About me"),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFieldCustom(
                        maxLine: 4,
                        controller: discriptionController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Interests (use , to seperate)"),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFieldCustom(
                        maxLine: 3,
                        controller: interestsController,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
