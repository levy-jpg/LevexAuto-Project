import 'package:flutter/material.dart';
import 'package:levexauto/constants/app_sizes.dart';

import '../../../constants/constants.dart';

class HeadingTextWidget extends StatelessWidget {
  final String text;

  const HeadingTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPadding16),
      child: Text(
        text,
        style: poppinsSemiBold.copyWith(
          color: AppColors.whiteColor,
          fontSize: kFont16,
        ),
      ),
    );
  }
}
