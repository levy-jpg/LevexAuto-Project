import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/controllers/forgot_pass_controller.dart';
import 'package:levexauto/utils/validations.dart';
import 'package:levexauto/widgets/custom_button.dart';
import 'package:levexauto/widgets/custom_overlay_widget.dart';
import 'package:levexauto/widgets/custom_text_field.dart';

import '../../constants/constants.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPassController controller = Get.put(ForgotPassController());
    return Scaffold(
      /// body
      body: CustomOverlayWidget(
        isLoading: controller.isLoading.value,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Form(
              key: controller.key,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: kPadding16,
                  vertical: kPadding30,
                ),
                children: [
                  /// forgot pass text
                  Text(
                    AppStrings.forgotPassword,
                    style: poppinsSemiBold.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: kFont24,
                    ),
                  ),
                  SizedBox(height: height(context) * 0.02),
                  Text(
                    AppStrings.writeDownTheEmailHereToRecoverYourPassword,
                    style: poppinsMedium.copyWith(
                      color: AppColors.whiteColor.withOpacity(0.5),
                      fontSize: kFont14,
                    ),
                  ),

                  ///
                  SizedBox(height: height(context) * 0.07),
                  CustomTextField(
                    heading: AppStrings.emailAddress,
                    controller: controller.emailController,
                    hintText: AppStrings.enterYourEmail,
                    validator: AppValidations().emailValidation,
                  ),

                  /// buttons
                  SizedBox(height: height(context) * 0.05),
                  CustomButton(
                    onTap: () {
                      controller.sendResetPassLink();
                    },
                    buttonText: AppStrings.recoverPassword,
                  ),
                  SizedBox(height: height(context) * 0.02),
                  CustomButton(
                    onTap: () {
                      Get.back();
                    },
                    buttonText: AppStrings.back,
                    borderColor: AppColors.strokeColor,
                    buttonColor: AppColors.scaffoldColor,
                    buttonTextColor: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
