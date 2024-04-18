import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../controllers/dealership_controller.dart';
import '../../../utils/enums.dart';
import 'membership_box.dart';

class MembershipSelectWidget extends StatelessWidget {
  const MembershipSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DealershipController controller = Get.put(DealershipController());
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppStrings.membershipLevel,
            style: poppinsSemiBold.copyWith(
              color: AppColors.whiteColor,
              fontSize: kFont14,
            ),
          ),
          SizedBox(height: kPadding6),
          Text(
            AppStrings.selectYourMembershipLevel,
            style: poppinsMedium.copyWith(
              color: AppColors.whiteColor.withOpacity(0.3),
              fontSize: kFont10,
            ),
          ),
          SizedBox(height: height(context) * 0.02),
          MembershipBox(
            onTap: () {
              controller.membershipLevelSelect(MembershipLevel.platinum);
            },
            isActive:
                controller.membershipLevel.value == MembershipLevel.platinum,
            text: AppStrings.platinum,
          ),
          MembershipBox(
            onTap: () {
              controller.membershipLevelSelect(MembershipLevel.gold);
            },
            isActive: controller.membershipLevel.value == MembershipLevel.gold,
            text: AppStrings.gold,
          ),
          MembershipBox(
            onTap: () {
              controller.membershipLevelSelect(MembershipLevel.silver);
            },
            isActive:
                controller.membershipLevel.value == MembershipLevel.silver,
            text: AppStrings.silver,
          ),
          MembershipBox(
            onTap: () {
              controller.membershipLevelSelect(MembershipLevel.bronze);
            },
            isActive:
                controller.membershipLevel.value == MembershipLevel.bronze,
            text: AppStrings.bronze,
          ),
        ],
      ),
    );
  }
}
