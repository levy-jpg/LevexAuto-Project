import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class DealershipBox extends StatelessWidget {
  final VoidCallback onTap;
  final String headingText;
  final bool isActive;
  final String descText;

  const DealershipBox({
    super.key,
    required this.onTap,
    required this.headingText,
    required this.isActive,
    required this.descText,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: width(context),
        padding: EdgeInsets.all(kPadding16),
        decoration: BoxDecoration(
          color: AppColors.boxColor,
          borderRadius: BorderRadius.circular(kRadius10),
          border: Border.all(
            color: AppColors.strokeColor,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    headingText,
                    style: poppinsSemiBold.copyWith(
                      color: AppColors.whiteOneColor,
                      fontSize: kFont14,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive
                          ? AppColors.primaryColor
                          : AppColors.strokeColor,
                      width: 2.0,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                      isActive ? AppColors.primaryColor : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: kPadding10),
            Text(
              descText,
              style: poppinsRegular.copyWith(
                color: AppColors.whiteOneColor,
                fontSize: kFont10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
