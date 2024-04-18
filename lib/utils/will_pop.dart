import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'custom_toast.dart';

class WillPopHelper {
  static DateTime? lastPressedAt;

  static Future<bool> doubleTapToClose() async {
    final now = DateTime.now();
    if (lastPressedAt == null ||
        now.difference(lastPressedAt!) > const Duration(seconds: 2)) {
      lastPressedAt = now;

      CustomToast().showToast(msgText: "Tap again to close the application");

      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      exitApp();
      return Future.value(true);
    }
  }

  static Future<bool> tapToBack() async {
    Get.back();
    return Future.value(true);
  }

  static void exitApp() {
    if (Platform.isAndroid) {
      exit(0);
    } else if (Platform.isIOS) {
      Navigator.of(Get.context!).popUntil(
        (route) => route.isFirst,
      );
    }
  }
}
