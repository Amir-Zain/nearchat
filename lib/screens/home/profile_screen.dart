import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logger/logger.dart';
import 'package:nearchat/ui/theme/appcolors.dart';

class ProfileScreen extends StatefulWidget {
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    DocumentSnapshot data =
        await _firestore.collection("users").doc(loggedUser.uid).get();
    logger.w(data.data());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Hello Appbar",
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.menu, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
