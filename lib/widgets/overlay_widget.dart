import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../controllers/overlay_controller.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    OverlayController progressController = Get.put(OverlayController());
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.5;
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
            SizedBox(
              width: width(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// logo
                  const Expanded(child: SizedBox()),
                  Image.asset(AppImages.appLogo),

                  ///
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),

            ///
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: Center(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.loading,
                        style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: kFont14,
                        ),
                      ),
                      SizedBox(height: kPadding10),
                      Container(
                        height: 10,
                        width: containerWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.whiteColor.withOpacity(0.1),
                        ),
                        child: Stack(
                          children: [
                            /// Left side progress
                            Align(
                              alignment: Alignment.center,
                              child: ClipRect(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  widthFactor: 0.9,
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerRight,
                                    widthFactor:
                                        progressController.progress.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            /// Right side progress
                            Align(
                              alignment: Alignment.center,
                              child: ClipRect(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 0.9,
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor:
                                        progressController.progress.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
