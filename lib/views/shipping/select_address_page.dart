import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../controllers/shipping_controller.dart';
import '../../widgets/custom_overlay_widget.dart';
import '../../widgets/widgets.dart';
import 'add_shipping_address.dart';
import 'components/add_address_box.dart';
import 'components/delivery_address_box.dart';
import 'shipping_progress_page.dart';

class SelectAddressPage extends StatefulWidget {
  var carPostData;

  SelectAddressPage({super.key, required this.carPostData});

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  ShippingController controller = Get.put(ShippingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.address),

      /// body
      body: Obx(
        () => CustomOverlayWidget(
          isLoading: controller.purchaseLoading.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// add address
              SizedBox(height: height(context) * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding20),
                child: Text(
                  AppStrings.addAddress,
                  style: poppinsSemiBold.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: kFont16,
                  ),
                ),
              ),
              SizedBox(height: height(context) * 0.016),

              /// box
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding20),
                child: AddAddressBox(onTap: () {
                  Get.to(const AddShippingAddress());
                }),
              ),
              SizedBox(height: height(context) * 0.03),

              /// text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding20),
                child: Text(
                  AppStrings.shippingAddress,
                  style: poppinsSemiBold.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: kFont16,
                  ),
                ),
              ),

              /// selectable address box
              Expanded(
                child:controller.shippingAddresses.isNotEmpty?
                ListView.builder(
                  itemCount: controller.shippingAddresses.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: kPadding20),
                  itemBuilder: (context, index) {
                    return DeliveryAddressBox(
                      onTap: () {
                        controller.updateSelectedAddress(index);
                        setState(() {});
                      },
                      headingText: controller.shippingAddresses[index]
                          ['address'],
                      addressText:
                          '${controller.shippingAddresses[index]['city']} ${controller.shippingAddresses[index]['state']},${controller.shippingAddresses[index]['country']}',
                      isActive: controller.selectedAddress.value == index
                          ? true
                          : false,
                    );
                  },
                ):
                Center(
                  child: Text('No address found',style:poppinsMedium.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: kFont20,
                  ),),
                ),
              ),

              /// button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding16),
                child: CustomButton(
                  onTap: () async {
                    var trackingId = await controller.purchaseCar(
                        postData: widget.carPostData);
                    Get.to(
                      ShippingProgressPage(
                        trackingId: trackingId,
                      ),
                    );
                  },
                  buttonText: AppStrings.next,
                ),
              ),
              SizedBox(height: height(context) * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
