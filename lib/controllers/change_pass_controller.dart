import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../utils/utils.dart';

class ChangePassController extends GetxController {
  TextEditingController currentController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController newAgainController = TextEditingController();
  Rx<bool> isCurrentObscure = true.obs;
  Rx<bool> isNewObscure = true.obs;
  Rx<bool> isNewAgainObscure = true.obs;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void currentVisibleFun() {
    isCurrentObscure.value = !isCurrentObscure.value;
  }

  void newVisibleFun() {
    isNewObscure.value = !isNewObscure.value;
  }

  void newAgainVisibleFun() {
    isNewAgainObscure.value = !isNewAgainObscure.value;
  }

  void changePassword() async {
    if (key.currentState!.validate()) {
      isLoading.value = true;

      var user = _auth.currentUser;
      if (user != null) {
        try {
          final cred = EmailAuthProvider.credential(
            email: user.email ?? "",
            password: currentController.text,
          );
          await FirebaseAuth.instance.currentUser
              ?.reauthenticateWithCredential(cred);
          try {
            var password = await user.updatePassword(newController.text);
            currentController.clear();
            newController.clear();
            newAgainController.clear();
            CustomToast().showToast(
              msgText: "Password updated successfully",
              bgColor: AppColors.greenLightColor,
              textColor: AppColors.whiteColor,
            );
            isLoading.value = false;
          } on FirebaseAuthException catch (e) {
            isLoading.value = false;
            CustomToast().showToast(
              msgText: e.message.toString(),
              bgColor: AppColors.primaryColor,
            );
          }
        } on FirebaseAuthException catch (e) {
          isLoading.value = false;
          CustomToast().showToast(
            msgText: 'Your current password is wrong',
            bgColor: AppColors.primaryColor,
          );
        }
      }
    } else {
      isLoading.value = false;
    }
  }
}
