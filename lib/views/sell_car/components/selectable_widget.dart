import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class SelectableWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isActive;

  const SelectableWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        height: height(context) * 0.06,
        width: width(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius10),
          color: isActive ? AppColors.primaryColor : AppColors.boxColor,
        ),
        child: Center(
          child: Text(
            text,
            style: poppinsMedium.copyWith(
              color: AppColors.whiteColor,
              fontSize: kFont14,
            ),
          ),
        ),
      ),
    );
  }
}
