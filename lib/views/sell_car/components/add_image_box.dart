import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AddImageBox extends StatelessWidget {
  final VoidCallback onTap;

  const AddImageBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: SizedBox(
        height: height(context) * 0.125,
        width: height(context) * 0.125,
        child: Stack(
          children: [
            SvgPicture.asset(AppIcons.borderBox),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.camera),
                  SizedBox(height: kPadding10),
                  Text(
                    AppStrings.addImages,
                    style: poppinsMedium.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: kFont12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
