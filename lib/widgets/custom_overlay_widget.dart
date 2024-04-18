import 'package:flutter/material.dart';
import 'package:levexauto/constants/constants.dart';

class CustomOverlayWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const CustomOverlayWidget({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        isLoading
            ? Container(
                height: height(context),
                width: width(context),
                color: AppColors.blackColor.withOpacity(0.2),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
