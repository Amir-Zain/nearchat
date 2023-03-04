import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:nearchat/models/user_model.dart';
import 'package:nearchat/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  PermissionService permissionService = PermissionService();
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  Future uploadImage(ChatUser user) async {
    final _firebaseStorage = FirebaseStorage.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _imagePicker = ImagePicker();
    XFile? image;
    bool persmission = await permissionService.requestImagesPermission();
    if (persmission) {
      image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final uid = user.uid;
        var file = File(image.path);
        try {
          var snapshot = await _firebaseStorage
              .ref()
              .child('profiles/$uid')
              .putFile(file)
              .whenComplete(() => null);
          var downloadUrl = await snapshot.ref.getDownloadURL();
          user.avatar = downloadUrl;
          await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .set(user.toJson());
          String userData = jsonEncode(user.toJson());
          prefs.setString("userData", userData);
        } catch (e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        }
      } else {
        logger.e("no image provide");
      }
    } else {
      logger.e("no permision");
    }
  }

  selectImage() async {
    final _imagePicker = ImagePicker();
    XFile? image;
    bool persmission = await permissionService.requestImagesPermission();
    if (persmission) {
      image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      } else {
        return;
      }
    } else {
      return;
    }
  }

  Future updateProfile(ChatUser user, File? avatar) async {
    final _firebaseStorage = FirebaseStorage.instance;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (avatar != null) {
      try {
        var snapshot = await _firebaseStorage
            .ref()
            .child('profiles/${user.uid}')
            .putFile(avatar)
            .whenComplete(() => null);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        user.avatar = downloadUrl;
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set(user.toJson());
        String userData = jsonEncode(user.toJson());
        prefs.setString("userData", userData);
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    } else {
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set(user.toJson());
        String userData = jsonEncode(user.toJson());
        prefs.setString("userData", userData);
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    }
  }

  Future<File> urlToFile(String imageUrl) async {
    // generate random number.
    var rng = Random(); // get temporary directory of device.
    Directory tempDir =
        await getTemporaryDirectory(); // get temporary path from temporary directory.
    String tempPath = tempDir
        .path; // create a new file in temporary path with random file name.
    File file = File(
        '$tempPath${rng.nextInt(100)}.png'); // call http.get method and pass imageUrl into it to get response.
    Uri? uri = Uri.tryParse(imageUrl);
    http.Response response =
        await http.get(uri!); // write bodyBytes received in response to file.
    await file.writeAsBytes(response
        .bodyBytes); // now return the file which is created with random name in
    // temporary directory and image bytes from response is written to that file.
    return file;
  }
}
