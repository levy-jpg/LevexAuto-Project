import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/controllers/signup_controller.dart';
import 'package:levexauto/utils/utils.dart';
import 'package:levexauto/views/signin/signin_page.dart';
import 'package:levexauto/widgets/custom_overlay_widget.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignupController controller = Get.put(SignupController());
    return WillPopScope(
      onWillPop: WillPopHelper.doubleTapToClose,
      child: Obx(
        () => Scaffold(
          /// body
          body: CustomOverlayWidget(
            isLoading: controller.isLoading.value,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SafeArea(
                child: Form(
                  key: controller.signUpKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: kPadding16,
                      vertical: kPadding30,
                    ),
                    children: [
                      /// sign in text
                      Text(
                        AppStrings.signUp,
                        style: poppinsSemiBold.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: kFont24,
                        ),
                      ),
                      SizedBox(height: height(context) * 0.06),

                      /// username field
                      CustomTextField(
                        heading: AppStrings.username,
                        controller: controller.usernameController,
                        hintText: AppStrings.enterYourName,
                        validator: AppValidations().nameValidation,
                      ),
                      SizedBox(height: height(context) * 0.02),

                      /// email field
                      CustomTextField(
                        heading: AppStrings.emailAddress,
                        controller: controller.emailController,
                        hintText: AppStrings.enterYourEmail,
                        validator: AppValidations().emailValidation,
                      ),
                      SizedBox(height: height(context) * 0.02),

                      /// password field
                      CustomTextField(
                        heading: AppStrings.password,
                        controller: controller.passwordController,
                        hintText: AppStrings.enterYourPassword,
                        isObscure: controller.isObscure.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.passObscureFun();
                          },
                          icon: SvgPicture.asset(AppIcons.eyeOff),
                        ),
                        validator: AppValidations().passwordValidation,
                      ),
                      SizedBox(height: height(context) * 0.02),

                      /// confirm password field
                      CustomTextField(
                        heading: AppStrings.confirmPassword,
                        controller: controller.confirmPassController,
                        hintText: AppStrings.enterYourPasswordAgain,
                        isObscure: controller.isConfirmObscure.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.confirmPassObscureFun();
                          },
                          icon: SvgPicture.asset(AppIcons.eyeOff),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          } else if (controller.confirmPassController.text !=
                              controller.passwordController.text) {
                            return 'Password not matched';
                          }
                          return null;
                        },
                      ),

                      /// signin button
                      SizedBox(height: height(context) * 0.08),
                      CustomButton(
                        onTap: () {
                          controller.signup();
                          // Get.to(MainMenuPage());
                        },
                        buttonText: AppStrings.signUp,
                      ),

                      /// already have an account
                      SizedBox(height: height(context) * 0.03),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.alreadyHaveAnAccountLogin,
                            style: poppinsMedium.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: kFont16,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAll(const SignInPage());
                            },
                            borderRadius: BorderRadius.circular(kRadius30),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppStrings.login,
                                style: poppinsMedium.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: kFont16,
                                ),
                              ),
                            ),
                          ),
                        ],
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
