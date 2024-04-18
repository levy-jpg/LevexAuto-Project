import 'package:flutter/material.dart';

import '../constants/constants.dart';

class SocialButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String? iconUrl;
  final String? btnText;

  const SocialButtonWidget({
    super.key,
    required this.onTap,
    this.iconUrl,
    this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        height: height(context) * 0.065,
        width: width(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius100),
          color: AppColors.whiteColor.withOpacity(0.2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// logo
            SvgPicture.asset(
              iconUrl ?? AppIcons.google,
              height: 20,
            ),
            SizedBox(width: kPadding20),
            Text(
              btnText ?? AppStrings.continueWithGoogle,
              style: poppinsMedium.copyWith(
                fontSize: kFont14,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
