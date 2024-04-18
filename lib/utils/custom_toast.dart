import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/constants.dart';

class CustomToast {
  void showToast({
    required String msgText,
    Color? bgColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
      msg: msgText,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor ?? AppColors.blackColor,
      textColor: textColor ?? AppColors.whiteColor,
      fontSize: 16.0,
    );
  }
}
