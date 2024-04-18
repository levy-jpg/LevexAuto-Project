import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/app_colors.dart';
import 'package:levexauto/utils/custom_toast.dart';

class ForgotPassController extends GetxController {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;

  Future<void> sendResetPassLink() async {
    if (key.currentState!.validate()) {
      isLoading.value = true;
      try {
        await _auth
            .sendPasswordResetEmail(email: emailController.text)
            .then((value) {
          CustomToast().showToast(
            msgText: 'Reset Password link send to your email',
            bgColor: AppColors.greenDarkColor,
          );
          isLoading.value = false;
          Get.back();
        });
      } catch (e) {
        debugPrint("Error: $e");
        CustomToast().showToast(
          msgText: "Error: $e",
          bgColor: AppColors.primaryColor,
        );
      }
    }
  }
}
