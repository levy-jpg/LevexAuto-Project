import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/controllers/contact_us_controller.dart';
import 'package:levexauto/utils/validations.dart';
import 'package:levexauto/widgets/custom_overlay_widget.dart';
import 'package:levexauto/widgets/widgets.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ContactUsController controller = Get.put(ContactUsController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        /// appbar
        appBar: const CustomAppbarWidget(text: AppStrings.contactUs),

        /// body
        body: Obx(
          () => CustomOverlayWidget(
            isLoading: controller.isLoading.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: kPadding16,
                      vertical: kPadding24,
                    ),
                    child: Form(
                      key: controller.key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// logo image
                          Image.asset(
                            AppImages.logo1,
                            height: height(context) * 0.1,
                          ),
                          SizedBox(height: height(context) * 0.06),

                          /// fields
                          CustomTextField(
                            heading: AppStrings.username,
                            controller: usernameController,
                            hintText: AppStrings.enterYourName,
                            validator: (value) {
                              return AppValidations().requiredField(
                                value,
                                msgText: 'Please enter your name',
                              );
                            },
                          ),
                          SizedBox(height: height(context) * 0.02),

                          CustomTextField(
                            heading: AppStrings.emailAddress,
                            controller: emailController,
                            hintText: 'Your@email.co.uk',
                            validator: (value) {
                              return AppValidations().requiredField(
                                value,
                                msgText: 'Please enter your email',
                              );
                            },
                          ),
                          SizedBox(height: height(context) * 0.02),

                          CustomTextField(
                            heading: AppStrings.description,
                            controller: messageController,
                            hintText: AppStrings.enterYourMessage,
                            minLines: 6,
                            maxLines: 6,
                            validator: AppValidations().requiredField,
                          ),

                          SizedBox(height: height(context) * 0.3),
                        ],
                      ),
                    ),
                  ),
                ),

                ///
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPadding16),
                  child: CustomButton(
                    onTap: () {
                      controller.sendMail();
                    },
                    buttonText: AppStrings.submit,
                  ),
                ),
                SizedBox(height: height(context) * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
