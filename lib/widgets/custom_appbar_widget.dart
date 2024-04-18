import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final bool autoBack;

  const CustomAppbarWidget({
    super.key,
    required this.text,
    this.autoBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffoldColor,
      centerTitle: true,
      automaticallyImplyLeading: autoBack,
      iconTheme: const IconThemeData(
        color: AppColors.whiteColor,
      ),
      title: Text(
        text,
        style: poppinsSemiBold.copyWith(
          color: AppColors.whiteColor,
          fontSize: kFont16,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
