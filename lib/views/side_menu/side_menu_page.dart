import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/services/auth_services.dart';
import 'package:levexauto/views/contact_us/contact_us_page.dart';
import 'package:levexauto/views/settings/settings_page.dart';
import 'package:levexauto/widgets/widgets.dart';

import '../dealership/dealership_page.dart';
import '../order_recipts/order_reciept_page.dart';
import 'components/close_drawer_btn.dart';
import 'components/side_menu_btn.dart';

class SideMenuPage extends StatelessWidget {
  const SideMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context),
      width: width(context) / 1.5,
      color: AppColors.primaryOneColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// close drawer button
          SizedBox(height: height(context) * 0.05),
          const CloseDrawerButton(),

          /// logo
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: height(context) * 0.024),
              children: [
                Center(
                  child: Image.asset(
                    AppImages.logo1,
                    height: height(context) * 0.12,
                  ),
                ),

                ///
                SizedBox(height: height(context) * 0.035),
                SideMenuBtn(
                  onTap: () {
                    Get.to(const DealershipPage());
                    Scaffold.of(context).closeDrawer();
                  },
                  iconUrl: AppIcons.dealership,
                  text: AppStrings.dealership,
                ),
                SideMenuBtn(
                  onTap: () {

                    Get.to(const OrderReceiptPage());
                    Scaffold.of(context).closeDrawer();
                  },
                  iconUrl: AppIcons.orderReceipt,
                  text: AppStrings.orderReceipt,
                ),
                SideMenuBtn(
                  onTap: () {
                    Get.to(ContactUsPage());
                    Scaffold.of(context).closeDrawer();
                  },
                  iconUrl: AppIcons.contactUs,
                  text: AppStrings.contactUs,
                ),
                SideMenuBtn(
                  onTap: () {
                    Get.to(SettingsPage());
                    Scaffold.of(context).closeDrawer();
                  },
                  iconUrl: AppIcons.settings,
                  text: AppStrings.settings,
                ),
              ],
            ),
          ),

          /// button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: height(context) * 0.024),
            child: CustomButton(
              onTap: () {
                AuthServices().userLogout();
              },
              buttonText: AppStrings.logOut,
            ),
          ),
          SizedBox(height: height(context) * 0.03),
        ],
      ),
    );
  }
}
