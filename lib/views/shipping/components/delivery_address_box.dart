import 'package:flutter/material.dart';
import 'package:levexauto/constants/constants.dart';

class DeliveryAddressBox extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String? headingText;
  final String? addressText;
  final bool? isSelectable;

  const DeliveryAddressBox({
    super.key,
    required this.onTap,
    required this.isActive,
    this.headingText,
    this.addressText,
    this.isSelectable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width: width(context),
        margin: EdgeInsets.only(top: kPadding16),
        padding: EdgeInsets.symmetric(
          horizontal: kPadding16,
          vertical: kPadding12,
        ),
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
            SvgPicture.asset(AppIcons.shareLocation),
            SizedBox(width: height(context) * 0.016),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    headingText ?? 'Mon Address',
                    style: poppinsRegular.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: kFont14,
                    ),
                  ),
                  Text(
                    addressText ?? '389,Rue 233, Los Angles, CA',
                    style: poppinsRegular.copyWith(
                      color: AppColors.greyOneColor,
                      fontSize: kFont12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: height(context) * 0.02),
            isSelectable == true
                ? Container(
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive
                            ? AppColors.primaryColor
                            : AppColors.greyOneColor,
                        width: 2.0,
                      ),
                    ),
                    child: isActive
                        ? Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                          )
                        : const SizedBox(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
