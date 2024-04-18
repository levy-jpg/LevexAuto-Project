import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class SettingButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SettingButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kPadding16),
      child: Bounceable(
        onTap: onTap,
        child: Container(
          width: width(context),
          padding: EdgeInsets.all(kPadding16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius10),
            color: AppColors.whiteColor.withOpacity(0.05),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: poppinsMedium.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: kFont16,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                size: 20,
                color: AppColors.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
