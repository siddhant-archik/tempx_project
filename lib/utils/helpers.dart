import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class Helpers {
  double getHeight(BuildContext context, double size) {
    double devHeight = MediaQuery.of(context).size.height;
    var respSize = size / devHeight;

    return devHeight * respSize;
  }

  double getWidth(BuildContext context, double size) {
    double devWidth = MediaQuery.of(context).size.width;
    var respSize = size / devWidth;

    return devWidth * respSize;
  }

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }
}
