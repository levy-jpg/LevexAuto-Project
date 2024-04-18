import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/controllers/main_menu_controller.dart';
import 'package:levexauto/views/home/home_page.dart';
import 'package:levexauto/views/saved/saved_page.dart';
import 'package:levexauto/views/sell_car/sell_car_page.dart';
import 'package:levexauto/views/track_order/track_orders_page.dart';

import '../side_menu/side_menu_page.dart';
import 'appbar_widget.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final List<Widget> _screens = [
    const HomePage(),
     TrackOrdersPage(),
    const SellCarPage(),
    const SavedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    MainMenuController controller = Get.put(MainMenuController());
    return Obx(
      () => Scaffold(
        /// appbar
        appBar:
            controller.currentIndex.value == 0 ? const AppbarWidget() : null,

        /// drawer
        drawer: const SideMenuPage(),

        ///
        body: _screens[controller.currentIndex.value],

        /// bottom nav
        bottomNavigationBar: SizedBox(
          height: height(context) * 0.09,
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.setTab,
            backgroundColor: AppColors.primaryOneColor,
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.whiteColor.withOpacity(0.3),
            selectedFontSize: kFont10,
            unselectedFontSize: kFont10,
            selectedLabelStyle: poppinsMedium,
            unselectedLabelStyle: poppinsMedium,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.home,
                  color: AppColors.whiteColor.withOpacity(0.3),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.home,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.home,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.trackOrder,
                  color: AppColors.whiteColor.withOpacity(0.3),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.trackOrder,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.trackOrders,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.carTag,
                  color: AppColors.whiteColor.withOpacity(0.3),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.carTag,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.sellCar,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppIcons.bookmarkFill,
                  color: AppColors.whiteColor.withOpacity(0.3),
                ),
                activeIcon: SvgPicture.asset(
                  AppIcons.bookmarkFill,
                  color: AppColors.primaryColor,
                ),
                label: AppStrings.saved,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
