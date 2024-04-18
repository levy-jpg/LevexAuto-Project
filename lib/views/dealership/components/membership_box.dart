import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class MembershipBox extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String text;

  const MembershipBox({
    super.key,
    required this.onTap,
    required this.isActive,
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
            color: AppColors.boxColor,
            borderRadius: BorderRadius.circular(kRadius10),
            border: Border.all(
              color: isActive ? AppColors.primaryColor : AppColors.strokeColor,
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: poppinsMedium.copyWith(
                    color: AppColors.whiteColor,
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
        ),
      ),
    );
  }
}
