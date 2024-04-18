import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class SellReasonBox extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String iconUrl;
  final String text;

  const SellReasonBox({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.iconUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: width(context),
        height: height(context) * 0.064,
        padding: EdgeInsets.symmetric(horizontal: kPadding16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius10),
          border: Border.all(
            color: isActive ? AppColors.primaryColor : AppColors.strokeColor,
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconUrl),
            SizedBox(width: height(context) * 0.016),
            Text(
              text,
              style: poppinsMedium.copyWith(
                color: AppColors.whiteColor,
                fontSize: kFont16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
