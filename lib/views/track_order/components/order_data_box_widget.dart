import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/constants.dart';
import '../../../controllers/shipping_controller.dart';
import 'order_data_text_widget.dart';

class OrderDataBoxWidget extends StatelessWidget {
  String trackingId;
  String address;
  OrderDataBoxWidget({super.key,required this.trackingId,required this.address});
  ShippingController controller = Get.put(ShippingController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      padding: EdgeInsets.all(kPadding16),
      decoration: BoxDecoration(
        color: AppColors.boxColor,
        borderRadius: BorderRadius.circular(kRadius10),
        border: Border.all(
          color: AppColors.strokeColor,
          width: 1.0,
        ),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OrderDataTextWidget(
            titleText: AppStrings.trackID,
            valueText: '#$trackingId',
            valueTextColor: AppColors.greenLightColor,
          ),
          OrderDataTextWidget(
            titleText: AppStrings.pickUpDate,
            valueText: DateFormat.yMMMd().format(DateTime.now().add(const Duration(days: 20))),
          ),
          OrderDataTextWidget(
            titleText: AppStrings.location,
            valueText: address,
          ),
          const OrderDataTextWidget(
            titleText: AppStrings.shippingMethod,
            valueText: 'CARGO',
            isBottomPadding: false,
          ),
        ],
      ),
    );
  }
}
