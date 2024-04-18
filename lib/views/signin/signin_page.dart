import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/controllers/signin_controller.dart';
import 'package:levexauto/utils/utils.dart';
import 'package:levexauto/views/forgot_password/forgot_password_page.dart';
import 'package:levexauto/views/signup/signup_page.dart';
import 'package:levexauto/widgets/custom_overlay_widget.dart';

import '../../widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController controller = Get.put(SignInController());
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
                  key: controller.key,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: kPadding16,
                      vertical: kPadding30,
                    ),
                    children: [
                      /// sign in text
                      Text(
                        AppStrings.signIn,
                        style: poppinsSemiBold.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: kFont24,
                        ),
                      ),
                      SizedBox(height: height(context) * 0.03),

                      /// buttons
                      SocialButtonWidget(
                        onTap: () {},
                        iconUrl: AppIcons.google,
                        btnText: AppStrings.continueWithGoogle,
                      ),
                      SizedBox(height: height(context) * 0.02),
                      SocialButtonWidget(
                        onTap: () {},
                        iconUrl: AppIcons.facebook,
                        btnText: AppStrings.continueWithFacebook,
                      ),

                      /// or
                      SizedBox(height: height(context) * 0.03),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              height: 1.0,
                              thickness: 1.0,
                              color: AppColors.whiteColor.withOpacity(0.1),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: kPadding10),
                            child: Text(
                              'or',
                              style: poppinsMedium.copyWith(
                                fontSize: kFont14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              height: 1.0,
                              thickness: 1.0,
                              color: AppColors.whiteColor.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),

                      /// fields
                      SizedBox(height: height(context) * 0.032),
                      CustomTextField(
                        heading: AppStrings.emailAddress,
                        controller: controller.emailController,
                        hintText: AppStrings.enterYourEmail,
                        validator: AppValidations().emailValidation,
                      ),

                      SizedBox(height: height(context) * 0.02),
                      CustomTextField(
                        heading: AppStrings.password,
                        controller: controller.passwordController,
                        hintText: AppStrings.enterYourPassword,
                        isObscure: controller.isObscure.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.passVisibleFun();
                          },
                          icon: SvgPicture.asset(AppIcons.eyeOff),
                        ),
                        validator: AppValidations().passwordValidation,
                      ),

                      /// signin button
                      SizedBox(height: height(context) * 0.04),
                      CustomButton(
                        onTap: () {
                          //controller.moveToNextScreen();
                          controller.login();
                        },
                        buttonText: AppStrings.signIn,
                      ),
                      SizedBox(height: height(context) * 0.02),
                      CustomButton(
                        onTap: () {
                          Get.to(ForgotPasswordPage());
                        },
                        buttonText: AppStrings.forgotYourPassword,
                        buttonColor: AppColors.scaffoldColor,
                        borderColor: AppColors.whiteColor,
                      ),

                      /// already have an account
                      SizedBox(height: height(context) * 0.03),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.newHere,
                            style: poppinsMedium.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: kFont16,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAll(SignupPage());
                            },
                            borderRadius: BorderRadius.circular(kRadius30),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppStrings.createAnAccount,
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
