import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color? buttonColor;
  final Color? splashColor;
  final Color? buttonTextColor;
  final Color? borderColor;
  final double? fontSize;
  final double? radius;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.buttonColor = AppColors.primaryColor,
    this.splashColor = AppColors.whiteColor,
    this.buttonTextColor = AppColors.whiteColor,
    this.borderColor = AppColors.primaryColor,
    this.fontSize,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: splashColor,
        shadowColor: Colors.transparent,
        maximumSize: Size.fromHeight(height(context) * 0.07),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? kRadius30),
        ),
        side: BorderSide(
          color: borderColor!,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: poppinsSemiBold.copyWith(
            color: buttonTextColor,
            fontSize: fontSize ?? kFont16,
          ),
        ),
      ),
    );
  }
}
