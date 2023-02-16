import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:nearchat/ui/theme/appcolors.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
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
          onTap: () {/* Write listener code here */},
          child: Icon(
            Icons.menu, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: 300,
              color: Colors.amber,
            ),
            Container(
              height: 300,
              width: 300,
              color: Colors.red,
            ),
            Container(
              height: 300,
              width: 300,
              color: Colors.yellow,
            ),
            Container(
              height: 300,
              width: 300,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
