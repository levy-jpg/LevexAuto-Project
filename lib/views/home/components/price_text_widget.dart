import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class PriceTextWidget extends StatelessWidget {
  final String titleText;
  final String valueText;

  const PriceTextWidget({
    super.key,
    required this.titleText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: kPadding16,
        right: kPadding16,
        bottom: height(context) * 0.015,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleText,
            style: poppinsMedium.copyWith(
              color: AppColors.whiteColor.withOpacity(0.8),
              fontSize: kFont12,
            ),
          ),
          Text(
            valueText,
            style: poppinsSemiBold.copyWith(
              color: AppColors.whiteOneColor,
              fontSize: kFont14,
            ),
          ),
        ],
      ),
    );
  }
}
