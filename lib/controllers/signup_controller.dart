import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/app_colors.dart';
import 'package:levexauto/services/auth_services.dart';
import 'package:levexauto/services/local_db.dart';
import 'package:levexauto/services/user_services.dart';
import 'package:levexauto/utils/custom_toast.dart';

import '../views/main_menu/main_menu_page.dart';

class SignupController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  final UserServices _userServices = UserServices();
  RxBool isObscure = true.obs;
  RxBool isConfirmObscure = true.obs;
  RxBool isLoading = false.obs;

  void passObscureFun() {
    isObscure.value = !isObscure.value;
  }

  void confirmPassObscureFun() {
    isConfirmObscure.value = !isConfirmObscure.value;
  }

  Future<void> signup() async {
    if (signUpKey.currentState!.validate()) {
      isLoading.value = true;

      String userId = await _authServices.registerWithEmailAndPass(
        email: emailController.text,
        password: passwordController.text,
      );

      /// upload data
      if (userId.isNotEmpty) {
        await LocalDB().saveUserId(userId);
        await _userServices
            .userSave(
                userId: userId,
                userName: usernameController.text,
                email: emailController.text)
            .then((value) {
          isLoading.value = false;

          ///
          Get.offAll(const MainMenuPage());
          CustomToast().showToast(
            msgText: 'User Data Successfully Save',
            bgColor: AppColors.greenDarkColor,
          );
        });
      } else {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
    }
  }
}
