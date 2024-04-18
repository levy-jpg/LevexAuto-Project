import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class TimerCardWidget extends StatelessWidget {
  final String countdownText;
  final String indicatorText;

  const TimerCardWidget({
    super.key,
    required this.countdownText,
    required this.indicatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: height(context) * 0.064,
          width: height(context) * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius12),
            color: AppColors.whiteColor.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              countdownText,
              style: poppinsSemiBold.copyWith(
                color: AppColors.whiteColor,
                fontSize: kFont18,
              ),
            ),
          ),
        ),
        SizedBox(height: kPadding10),
        Text(
          indicatorText,
          style: poppinsRegular.copyWith(
            color: AppColors.whiteColor,
            fontSize: kFont14,
          ),
        ),
      ],
    );
  }
}
