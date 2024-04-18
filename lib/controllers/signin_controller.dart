import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:levexauto/services/auth_services.dart';
import 'package:levexauto/views/main_menu/main_menu_page.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<bool> isObscure = true.obs;
  Rx<bool> isLoading = false.obs;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  final AuthServices _authServices = AuthServices();

  void passVisibleFun() {
    isObscure.value = !isObscure.value;
  }

  Future<void> login() async {
    if (key.currentState!.validate()) {
      isLoading.value = true;
      _authServices
          .userLoginFun(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) {
        isLoading.value = false;
      });
    }
  }
}
