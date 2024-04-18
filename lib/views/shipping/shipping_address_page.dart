import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/views/shipping/add_shipping_address.dart';
import 'package:levexauto/views/shipping/edit_shipping_address.dart';
import '../../constants/constants.dart';
import '../../controllers/shipping_controller.dart';
import '../../widgets/widgets.dart';
import 'components/delivery_address_box.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  @override
  Widget build(BuildContext context) {
    ShippingController controller = Get.put(ShippingController());
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.shippingAddress),

      /// body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Obx(
            () => controller.shippingAddresses.isEmpty
                ? Center(
                    child: Text(
                      "No shipping addresses found.",
                      style: poppinsRegular.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: kFont14,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    itemCount: controller.shippingAddresses.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var address = controller.shippingAddresses[index];
                      return DeliveryAddressBox(
                        onTap: () {
                          //controller.updateSelectedAddress(index);
                          Get.to(EditShippingAddress(address: address));
                        },
                        headingText: address['address'],
                        addressText:
                            '${address['city']} ${address['state']}, ${address['country']}',
                        isActive: false,
                        isSelectable: false,
                      );
                    },
                  ),
          )),

          /// button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding16),
            child: CustomButton(
              onTap: () {
                Get.to(const AddShippingAddress());
              },
              buttonText: AppStrings.addNewAddress,
            ),
          ),
          SizedBox(height: height(context) * 0.03),
        ],
      ),
    );
  }
}
