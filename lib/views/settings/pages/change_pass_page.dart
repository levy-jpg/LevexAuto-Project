import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/controllers/change_pass_controller.dart';
import 'package:levexauto/utils/validations.dart';
import 'package:levexauto/widgets/custom_overlay_widget.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePassController controller = Get.put(ChangePassController());
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
                        AppStrings.changePassword,
                        style: poppinsSemiBold.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: kFont24,
                        ),
                      ),
                      SizedBox(height: height(context) * 0.02),
                      Text(
                        AppStrings.writeDownTheDetailsToChangeYourPassword,
                        style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor.withOpacity(0.5),
                          fontSize: kFont14,
                        ),
                      ),
                      SizedBox(height: height(context) * 0.06),

                      /// current password field
                      CustomTextField(
                        heading: AppStrings.currentPassword,
                        controller: controller.currentController,
                        hintText: AppStrings.enterYourCurrentPassword,
                        isObscure: controller.isCurrentObscure.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.currentVisibleFun();
                          },
                          icon: SvgPicture.asset(AppIcons.eyeOff),
                        ),
                        validator: AppValidations().requiredField,
                      ),
                      SizedBox(height: height(context) * 0.02),

                      /// new password field
                      CustomTextField(
                        heading: AppStrings.newPassword,
                        controller: controller.newController,
                        hintText: AppStrings.enterYourNewPassword,
                        isObscure: controller.isNewObscure.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.newVisibleFun();
                          },
                          icon: SvgPicture.asset(AppIcons.eyeOff),
                        ),
                        validator: AppValidations().requiredField,
                      ),
                      SizedBox(height: height(context) * 0.02),

                      /// again password field
                      CustomTextField(
                        heading: AppStrings.confirmPassword,
                        controller: controller.newAgainController,
                        hintText: AppStrings.enterYourPasswordAgain,
                        isObscure: controller.isNewAgainObscure.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.newAgainVisibleFun();
                          },
                          icon: SvgPicture.asset(AppIcons.eyeOff),
                        ),
                        validator: (value) {
                          if (controller.newAgainController.text !=
                              controller.newController.text) {
                            return 'Password not matched';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height(context) * 0.06),

                      ///
                      CustomButton(
                        onTap: () {
                          controller.changePassword();
                        },
                        buttonText: AppStrings.changePassword,
                      ),
                      SizedBox(height: height(context) * 0.02),
                      CustomButton(
                        onTap: () {
                          Get.back();
                        },
                        buttonText: AppStrings.back,
                        buttonColor: AppColors.scaffoldColor,
                        buttonTextColor: AppColors.whiteColor,
                        borderColor: AppColors.whiteOneColor,
                      ),
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
