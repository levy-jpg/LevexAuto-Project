import 'package:flutter/material.dart';

import '../constants/constants.dart';

class MyTimeLineWidget extends StatelessWidget {
  final bool isCompleted;
  final bool isActive;
  final bool isLast;
  final String titleText;
  final String valueText;

  const MyTimeLineWidget({
    super.key,
    this.isCompleted = false,
    this.isActive = false,
    this.isLast = false,
    required this.titleText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? AppColors.primaryColor
                      : isActive
                          ? AppColors.yellowColor
                          : AppColors.whiteColor.withOpacity(0.2),
                ),
              ),
              isCompleted
                  ? Container(
                      width: 2.0,
                      height: height(context) * 0.07,
                      color: AppColors.primaryColor,
                    )
                  : isLast
                      ? const SizedBox()
                      : SvgPicture.asset(AppIcons.dottedLine),
            ],
          ),
        ),
        SizedBox(width: height(context) * 0.015),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: poppinsSemiBold.copyWith(
                color: AppColors.whiteOneColor,
                fontSize: kFont12,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              valueText,
              style: poppinsMedium.copyWith(
                color: AppColors.whiteColor.withOpacity(0.6),
                fontSize: kFont12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
