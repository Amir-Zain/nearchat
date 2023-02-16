import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:nearchat/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  Future signup(String email, String password, String name) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (exception) {
      Fluttertoast.showToast(
        msg: exception.code.toString(),
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
    if (credential != null) {
      String uid = credential.user!.uid;
      ChatUser newUser = ChatUser(
        uid: uid,
        email: email,
        name: name,
        // profilepic: "",
      );
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set(newUser.toJson())
            .then((value) {
          Fluttertoast.showToast(
            msg: "Account Created Succesfully",
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        });
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }
  }

  Future forgetPassword(String email) async {
    var credential;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Password reset email sended",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } on FirebaseAuthException catch (exception) {
      Fluttertoast.showToast(
        msg: exception.code.toString(),
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  Future login(String email, String password) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (exception) {
      Fluttertoast.showToast(
        msg: exception.code.toString(),
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }
    if (credential != null) {
      String uid = credential.user!.uid;
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      ChatUser loginUser =
          ChatUser.fromJson(userData.data() as Map<String, dynamic>);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", loginUser.email.toString());
      return "Success";
      //kk Navigator.push( context, MaterialPageRoute( builder: (context) => HomePage( chatUser: loginUser, firestoreuser: credential!.user!,)),);
    } else {
      Fluttertoast.showToast(
        msg: "Email/Password is incorrect",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }
}
