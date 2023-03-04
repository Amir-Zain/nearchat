import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestImagesPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        /// use [Permissions.storage.status]
        if (await Permission.storage.request().isGranted) {
          return true;
        } else {
          return false;
        }
      } else {
        if (await Permission.photos.request().isGranted) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      if (await Permission.photos.request().isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
