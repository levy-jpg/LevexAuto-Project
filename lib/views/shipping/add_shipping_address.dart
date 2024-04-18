import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/controllers/shipping_controller.dart';
import 'package:levexauto/widgets/widgets.dart';

import '../../constants/constants.dart';
import '../../widgets/custom_overlay_widget.dart';

class AddShippingAddress extends StatelessWidget {
  const AddShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    ShippingController controller = Get.put(ShippingController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        /// appbar
        appBar: const CustomAppbarWidget(text: AppStrings.addShippingAddress),

        /// body
        body: Obx(() => CustomOverlayWidget(
              isLoading: controller.loading.value,
              child: Form(
                key: controller.addAddressKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPadding16,
                    vertical: kPadding20,
                  ),
                  children: [
                    /// address field
                    CustomTextField(
                      heading: AppStrings.address,
                      controller: controller.addressController,
                      hintText: AppStrings.addAddress,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "Address is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// city field
                    CustomTextField(
                      heading: AppStrings.city,
                      controller: controller.cityController,
                      hintText: AppStrings.enterCity,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "City is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// country field
                    CustomTextField(
                      heading: AppStrings.country,
                      controller: controller.countryController,
                      hintText: AppStrings.enterCountry,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "Country is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// state field
                    CustomTextField(
                      heading: AppStrings.state,
                      controller: controller.stateController,
                      hintText: AppStrings.enterState,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "State is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// postal code field
                    CustomTextField(
                      heading: AppStrings.postalCode,
                      controller: controller.postalCodeController,
                      hintText: AppStrings.enterPostalCode,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "Postal Code is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height(context) * 0.08),

                    /// button
                    CustomButton(
                      onTap: () async {
                        await controller.addShippingAddress();
                      },
                      buttonText: AppStrings.addAddress,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
