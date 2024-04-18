import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class OrderDataTextWidget extends StatelessWidget {
  final bool isBottomPadding;

  final String titleText;
  final String valueText;
  final Color valueTextColor;

  const OrderDataTextWidget({
    super.key,
    this.isBottomPadding = true,
    required this.titleText,
    required this.valueText,
    this.valueTextColor = AppColors.whiteOneColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: isBottomPadding ? height(context) * 0.015 : 0.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleText,
            style: poppinsMedium.copyWith(
              color: AppColors.whiteColor.withOpacity(0.6),
              fontSize: kFont12,
            ),
          ),
          SizedBox(
            width: 180,
            child: Text(
              valueText,
              style: poppinsSemiBold.copyWith(
                color: valueTextColor,
                fontSize: kFont12,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
