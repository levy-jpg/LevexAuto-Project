import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height(context) * 0.11,
      backgroundColor: AppColors.primaryOneColor,
      centerTitle: true,
      title: Image.asset(
        AppImages.logo1,
        height: height(context) * 0.065,
      ),
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: AppColors.whiteColor,
        ),
      ),
      actions: [
        SizedBox(
          height: height(context) * 0.055,
          width: height(context) * 0.055,
          child: SvgPicture.asset(AppIcons.person),
        ),
        SizedBox(width: kPadding16)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(90);
}
