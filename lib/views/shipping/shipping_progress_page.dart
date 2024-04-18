import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:levexauto/views/main_menu/main_menu_page.dart';

import '../../constants/constants.dart';
import '../../controllers/shipping_controller.dart';
import '../../widgets/widgets.dart';
import '../track_order/components/order_data_box_widget.dart';

class ShippingProgressPage extends StatelessWidget {
  String trackingId;
   ShippingProgressPage({super.key,required this.trackingId});
  ShippingController controller = Get.put(ShippingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.shippingProgress),

      /// body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(kPadding16),
              children: [
                /// heading
                Text(
                  AppStrings.estimatedArrival,
                  style: poppinsSemiBold.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: kFont16,
                  ),
                ),
                SizedBox(height: height(context) * 0.016),

                /// indicator
                Stack(
                  children: [
                    Container(
                      height: 10,
                      width: width(context),
                      decoration: BoxDecoration(
                        color: AppColors.whiteOneColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(kRadius10),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: width(context) / 5,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(kRadius10),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height(context) * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'in 20 days',
                      style: poppinsMedium.copyWith(
                        color: AppColors.whiteOneColor,
                        fontSize: kFont12,
                      ),
                    ),
                    Text(
                      '20%',
                      style: poppinsMedium.copyWith(
                        color: AppColors.whiteOneColor,
                        fontSize: kFont12,
                      ),
                    ),
                  ],
                ),
                ///
                SizedBox(height: height(context) * 0.024),
                OrderDataBoxWidget(trackingId: trackingId,address: '${controller.shippingAddresses[controller.selectedAddress.value]['address']}',),
                /// timeline
                SizedBox(height: height(context) * 0.024),
                Text(
                  AppStrings.timeline,
                  style: poppinsSemiBold.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: kFont16,
                  ),
                ),

                /// timeline
                SizedBox(height: height(context) * 0.02),
                 MyTimeLineWidget(
                  titleText: AppStrings.orderPlaced,
                  valueText:  DateFormat.yMMMd().format(DateTime.now()),
                  isCompleted: true,
                ),
                 MyTimeLineWidget(
                  titleText: AppStrings.pickedUpFromDealer,
                  valueText:  DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 3))),
                  isActive: true,
                ),
                 MyTimeLineWidget(
                  titleText: AppStrings.arrivedAtPort,
                  valueText: DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 10))),
                ),
                 MyTimeLineWidget(
                  titleText: AppStrings.shipDeparts,
                  valueText: DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 15))),
                ),
                 MyTimeLineWidget(
                  titleText: AppStrings.arrivedAtLA,
                  valueText: DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 19))),
                  isLast: true,
                ),

                SizedBox(height: height(context) * 0.1),
              ],
            ),
          ),

          /// button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding16),
            child: CustomButton(
              onTap: () {
                Get.offAll(const MainMenuPage());
              },
              buttonText: AppStrings.backToHome,
            ),
          ),
          SizedBox(height: height(context) * 0.03),
        ],
      ),
    );
  }
}
