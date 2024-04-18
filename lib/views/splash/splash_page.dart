import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.put(SplashController());
    return Scaffold(
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Stack(
          children: [
            /// bottom car
            Positioned(
              bottom: 0.0,
              child: Image.asset(AppImages.carImage),
            ),

            ///
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.appLogo),
                  SizedBox(height: kPadding16),
                  const CircularProgressIndicator(
                      color: AppColors.primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
