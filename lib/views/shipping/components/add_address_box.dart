import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AddAddressBox extends StatelessWidget {
  final VoidCallback onTap;

  const AddAddressBox({super.key, required this.onTap});

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.selectLocation),
            SizedBox(width: height(context) * 0.024),
            Expanded(
              child: Text(
                AppStrings.selectLocation,
                style: poppinsMedium.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: kFont14,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
