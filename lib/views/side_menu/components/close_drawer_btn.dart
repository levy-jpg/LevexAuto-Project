import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class CloseDrawerButton extends StatelessWidget {
  const CloseDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Scaffold.of(context).closeDrawer();
      },
      child: Container(
        height: height(context) * 0.045,
        width: height(context) * 0.045,
        margin: EdgeInsets.only(left: kPadding20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.whiteColor.withOpacity(0.1),
        ),
        child: Center(
          child: SvgPicture.asset(AppIcons.closeIcon),
        ),
      ),
    );
  }
}
