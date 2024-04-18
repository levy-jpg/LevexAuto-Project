import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/views/settings/components/setting_button.dart';
import 'package:levexauto/views/settings/pages/change_pass_page.dart';
import 'package:levexauto/views/shipping/shipping_address_page.dart';
import 'package:levexauto/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.settings),

      /// body
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: kPadding16),
        children: [
          SizedBox(height: height(context) * 0.01),
          SettingButton(
            onTap: () {
              Get.to(ChangePasswordPage());
            },
            text: AppStrings.changePassword,
          ),
          SettingButton(
            onTap: () {
              Get.to(ShippingAddressPage());
            },
            text: AppStrings.shippingAddress,
          ),
        ],
      ),
    );
  }
}
