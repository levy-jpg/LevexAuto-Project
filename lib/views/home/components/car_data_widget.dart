import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class CarDataWidget extends StatelessWidget {
  final String? iconUrl;
  final String? headingText;
  final String? valueText;

  const CarDataWidget({
    super.key,
    this.iconUrl,
    this.headingText,
    this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: height(context) * 0.015,
        left: kPadding16,
        right: kPadding16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(iconUrl ?? AppIcons.menufecture),
          SizedBox(width: height(context) * 0.015),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  headingText ?? AppStrings.manufacturer,
                  style: poppinsMedium.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: kFont14,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  valueText ?? 'Porsche',
                  style: poppinsRegular.copyWith(
                    color: AppColors.greyLightColor,
                    fontSize: kFont12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
