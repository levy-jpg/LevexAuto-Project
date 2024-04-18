import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:levexauto/controllers/sell_car_controller.dart';
import 'package:levexauto/views/main_menu/main_menu_page.dart';
import 'package:levexauto/views/signin/signin_page.dart';

class SplashController extends GetxController {
  SellCarController controller = Get.put(SellCarController());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await controller.getLocation();
    Timer(
      const Duration(seconds: 3),
      () {
        if (_auth.currentUser != null) {
          Get.offAll(const MainMenuPage());
        } else {
          Get.offAll(const SignInPage());
        }
      },
    );
  }
}
