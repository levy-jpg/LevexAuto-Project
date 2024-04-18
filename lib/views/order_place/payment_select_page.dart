import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/views/shipping/select_address_page.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';
import 'components/confirm_car_box.dart';

class PaymentSelectPage extends StatelessWidget {
  var carPostData;

  PaymentSelectPage({super.key, required this.carPostData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.paymentMethod),

      /// body
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: kPadding16,
          vertical: kPadding20,
        ),
        children: [
          ///
          ConfirmCarBox(carPostdata: carPostData),
          SizedBox(height: height(context) * 0.024),

          ///
          Text(
            AppStrings.paymentMethod,
            style: poppinsSemiBold.copyWith(
              color: AppColors.whiteOneColor,
              fontSize: kFont16,
            ),
          ),
          SizedBox(height: height(context) * 0.016),

          ///
          Bounceable(
            onTap: () {},
            child: Container(
              width: width(context),
              padding: EdgeInsets.symmetric(
                horizontal: kPadding16,
                vertical: kPadding24,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kRadius10),
                color: AppColors.boxColor,
                border: Border.all(
                  color: AppColors.strokeColor,
                  width: 1.0,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///
                  Container(
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: height(context) * 0.01),
                  Expanded(
                    child: Text(
                      AppStrings.creditDebitCards,
                      style: poppinsMedium.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: kFont14,
                      ),
                    ),
                  ),
                  SvgPicture.asset(AppIcons.visaCard),
                  SizedBox(width: height(context) * 0.005),
                  SvgPicture.asset(AppIcons.mastercard),
                  SizedBox(width: height(context) * 0.005),
                  SvgPicture.asset(AppIcons.dinnerClubCard),
                  SizedBox(width: height(context) * 0.005),
                  SvgPicture.asset(AppIcons.discoverCard),
                ],
              ),
            ),
          ),
          SizedBox(height: height(context) * 0.06),

          ///
          Container(
            width: width(context),
            padding: EdgeInsets.all(kPadding10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kRadius10),
              color: AppColors.blueColor.withOpacity(0.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(AppIcons.secure),
                SizedBox(width: kPadding10),
                Expanded(
                  child: Text(
                    AppStrings.securePayment,
                    style: poppinsMedium.copyWith(
                      color: AppColors.whiteColor.withOpacity(0.8),
                      fontSize: kFont10,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.whiteColor,
                  size: 16,
                ),
              ],
            ),
          ),
          SizedBox(height: height(context) * 0.02),

          /// confirm order button
          CustomButton(
            onTap: () {
              Get.to(SelectAddressPage(
                carPostData: carPostData,
              ));
            },
            buttonText: AppStrings.confirmOrder,
          ),
          SizedBox(height: height(context) * 0.06),
        ],
      ),
    );
  }
}
