import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../controllers/dealership_controller.dart';
import '../../../utils/enums.dart';
import 'sell_reason_box.dart';

class SellingReasonWidget extends StatelessWidget {
  const SellingReasonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DealershipController controller = Get.put(DealershipController());
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.sellingReason,
                style: poppinsSemiBold.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: kFont14,
                ),
              ),
              Text(
                ' *',
                style: poppinsMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: kFont14,
                ),
              ),
            ],
          ),
          SizedBox(height: kPadding6),
          Text(
            AppStrings.selectYourCarSellingReason,
            style: poppinsMedium.copyWith(
              color: AppColors.whiteColor.withOpacity(0.3),
              fontSize: kFont10,
            ),
          ),
          SizedBox(height: height(context) * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SellReasonBox(
                  onTap: () {
                    controller.sellingReasonSelect(SellingReason.import);
                  },
                  isActive:
                      controller.sellingReason.value == SellingReason.import,
                  iconUrl: AppIcons.import,
                  text: AppStrings.import,
                ),
              ),
              SizedBox(width: height(context) * 0.024),
              Expanded(
                child: SellReasonBox(
                  onTap: () {
                    controller.sellingReasonSelect(SellingReason.local);
                  },
                  isActive:
                      controller.sellingReason.value == SellingReason.local,
                  iconUrl: AppIcons.local,
                  text: AppStrings.local,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
