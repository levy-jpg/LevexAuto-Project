import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/widgets/custom_overlay_widget.dart';

import '../../constants/constants.dart';
import '../../controllers/shipping_controller.dart';
import '../../widgets/widgets.dart';

class EditShippingAddress extends StatelessWidget {
  final Map<String, dynamic> address;
  final ShippingController controller = Get.find<ShippingController>();

  EditShippingAddress({super.key, required this.address}) {
    controller.addressController.text = address['address'];
    controller.cityController.text = address['city'];
    controller.countryController.text = address['country'];
    controller.stateController.text = address['state'];
    controller.postalCodeController.text = address['postcode'];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        /// appbar
        appBar: const CustomAppbarWidget(text: AppStrings.yourAddress),

        /// body
        body: Obx(
          () => CustomOverlayWidget(
            isLoading: controller.isLoading.value,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: kPadding16,
                vertical: kPadding20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    heading: AppStrings.address,
                    controller: controller.addressController,
                    hintText: AppStrings.addAddress,
                  ),
                  SizedBox(height: height(context) * 0.02),
                  CustomTextField(
                    heading: AppStrings.city,
                    controller: controller.cityController,
                    hintText: AppStrings.enterCity,
                  ),
                  SizedBox(height: height(context) * 0.02),
                  CustomTextField(
                    heading: AppStrings.country,
                    controller: controller.countryController,
                    hintText: AppStrings.enterCountry,
                  ),
                  SizedBox(height: height(context) * 0.02),
                  CustomTextField(
                    heading: AppStrings.state,
                    controller: controller.stateController,
                    hintText: AppStrings.enterState,
                  ),
                  SizedBox(height: height(context) * 0.02),
                  CustomTextField(
                    heading: AppStrings.postalCode,
                    controller: controller.postalCodeController,
                    hintText: AppStrings.enterPostalCode,
                  ),
                  SizedBox(height: height(context) * 0.032),
                  CustomButton(
                    onTap: () => controller.updateAddress(address),
                    buttonText: AppStrings.save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
