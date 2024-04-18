import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/utils/validations.dart';
import 'package:levexauto/widgets/custom_overlay_widget.dart';

import '../../constants/constants.dart';
import '../../controllers/dealership_controller.dart';
import '../../widgets/widgets.dart';
import 'components/membership_select_widget.dart';
import 'components/selling_reason_widget.dart';

class DealershipSignupPage extends StatelessWidget {
  const DealershipSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    DealershipController controller = Get.put(DealershipController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        /// body
        body: Obx(
          () => CustomOverlayWidget(
            isLoading: controller.isLoading.value,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: kPadding16,
                  vertical: kPadding30,
                ),
                child: Form(
                  key: controller.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// sign in text
                      Text(
                        AppStrings.signUp,
                        style: poppinsSemiBold.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: kFont24,
                        ),
                      ),
                      SizedBox(height: height(context) * 0.03),

                      /// username field
                      CustomTextField(
                        heading: AppStrings.username,
                        controller: controller.usernameController,
                        hintText: AppStrings.enterYourName,
                        validator: AppValidations().requiredField,
                      ),
                      SizedBox(height: height(context) * 0.02),

                      /// location field
                      CustomTextField(
                        heading: AppStrings.location,
                        controller: controller.locationController,
                        hintText: AppStrings.enterYourLocation,
                        validator: AppValidations().requiredField,
                      ),
                      SizedBox(height: height(context) * 0.02),

                      /// registration fee field
                      CustomTextField(
                        heading: AppStrings.registerFee,
                        controller: controller.registerFeeController,
                        hintText: AppStrings.enterYourRegisterFee,
                        validator: AppValidations().requiredField,
                      ),
                      SizedBox(height: height(context) * 0.02),

                      /// selling reason
                      const SellingReasonWidget(),
                      SizedBox(height: height(context) * 0.02),

                      /// membership level
                      const MembershipSelectWidget(),
                      SizedBox(height: height(context) * 0.06),

                      ///
                      CustomButton(
                        onTap: () {
                          controller.uploadDealership();
                        },
                        buttonText: AppStrings.signUp,
                      ),
                      SizedBox(height: height(context) * 0.06),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
