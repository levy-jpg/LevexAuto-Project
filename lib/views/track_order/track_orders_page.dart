import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/widgets/widgets.dart';

import '../../constants/constants.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/custom_overlay_widget.dart';
import 'components/track_order_box_widget.dart';

class TrackOrdersPage extends StatelessWidget {
  TrackOrdersPage({super.key});

  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    // controller.updateData();
    return Scaffold(
      appBar: const CustomAppbarWidget(
        text: AppStrings.trackOrders,
        autoBack: false,
      ),

      /// body
      body: Obx(() => CustomOverlayWidget(
            isLoading: controller.loading.value,
            child: controller.trackingOrders.isEmpty
                ? Center(
                    child: Text(
                      "No order Placed",
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
                            : TrackOrderBoxWidget(
                                trackingData: controller.trackingOrders[index],
                              ),
                      );
                    },
                  ),
          )),
    );
  }
}
