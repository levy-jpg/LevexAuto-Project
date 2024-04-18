import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/custom_overlay_widget.dart';
import '../track_order/components/track_order_box_widget.dart';
import 'Component/recieptBoxWidget.dart';

class OrderReceiptPage extends StatefulWidget {
  const OrderReceiptPage({super.key});

  @override
  State<OrderReceiptPage> createState() => _OrderReceiptPageState();
}

class _OrderReceiptPageState extends State<OrderReceiptPage> {
  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.orderReceipt),
      body: Obx(() => CustomOverlayWidget(
            isLoading: controller.loading.value,
            child: controller.trackingOrders.isEmpty
                ? Center(
                    child: Text(
                      "No order receipt found",
                      style: poppinsSemiBold.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: kFont16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.trackingOrders.length,
                    padding: EdgeInsets.symmetric(vertical: kPadding16),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: kPadding20),
                        child: controller.loading.value
                            ? const SizedBox()
                            : RecieptBoxWidget(
                                trackingData: controller.trackingOrders[index],
                              ),
                      );
                    },
                  ),
          )),
    );
  }
}
