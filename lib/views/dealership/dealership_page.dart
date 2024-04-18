import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/controllers/dealership_controller.dart';
import 'package:levexauto/utils/enums.dart';
import 'package:levexauto/widgets/widgets.dart';

import 'components/dealership_box.dart';
import 'dealership_signup_page.dart';

class DealershipPage extends StatelessWidget {
  const DealershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    DealershipController controller = Get.put(DealershipController());
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(
        text: AppStrings.dealership,
        autoBack: true,
      ),

      /// body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(
              () => ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: kPadding16,
                  vertical: kPadding24,
                ),
                children: [
                  /// logo image
                  Image.asset(
                    AppImages.logo1,
                    height: height(context) * 0.1,
                  ),
                  SizedBox(height: height(context) * 0.02),

                  /// texts
                  Text(
                    'Welcome to LevexAuto – your go-to for streamlined car imports. With us, importing vehicles is a breeze. Browse our wide selection, track shipments, and handle documentation effortlessly.',
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: kFont12,
                    ),
                  ),
                  SizedBox(height: height(context) * 0.04),

                  ///
                  DealershipBox(
                    onTap: () {
                      controller.dealerSelect(DealerType.kenya);
                    },
                    headingText: 'Kenya Dealership',
                    isActive: controller.dealerType.value == DealerType.kenya,
                    descText:
                        '"Explore our Kenya dealership for quality cars from top brands. Discover vehicles ranging from compact cars to luxury SUVs, all at competitive prices. Whether you need a reliable daily driver or a stylish weekend cruiser, we have the perfect car for you. Visit us today!"',
                  ),
                  SizedBox(height: height(context) * 0.02),
                  DealershipBox(
                    onTap: () {
                      controller.dealerSelect(DealerType.uk);
                    },
                    headingText: 'UK Dealership',
                    isActive: controller.dealerType.value == DealerType.uk,
                    descText:
                        '"Experience the best of British motoring at our UK dealership. Discover a wide range of vehicles from iconic British brands, known for their style, performance, and innovation. From classic models to the latest releases, we have something for every car enthusiast. Browse our inventory online or visit us today!"',
                  ),
                ],
              ),
            ),
          ),

          ///
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding16),
            child: CustomButton(
              onTap: () {
                Get.to(DealershipSignupPage());
              },
              buttonText: AppStrings.signupForLevexAuto,
            ),
          ),
          SizedBox(height: height(context) * 0.05),
        ],
      ),
    );
  }
}
