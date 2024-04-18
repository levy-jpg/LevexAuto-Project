import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ConfirmCarBox extends StatelessWidget {
  var carPostdata;
   ConfirmCarBox({super.key,required this.carPostdata});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      padding: EdgeInsets.all(kPadding16),
      decoration: BoxDecoration(
        color: AppColors.boxColor,
        borderRadius: BorderRadius.circular(kRadius10),
        border: Border.all(
          color: AppColors.strokeColor,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(context) * 0.08,
                width: height(context) * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadius12),
                  image:  DecorationImage(
                    image: NetworkImage(carPostdata['images'].first),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: height(context) * 0.015),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${carPostdata['manufacture']} ${carPostdata['model']}',
                      style: poppinsMedium.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: kFont16,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      '${carPostdata['modelYear']}',
                      style: poppinsRegular.copyWith(
                        color: AppColors.greyLightColor,
                        fontSize: kFont14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height(context) * 0.016),
          /// divider
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: AppColors.whiteColor.withOpacity(0.1),
          ),
          SizedBox(height: height(context) * 0.016),
          /// car price
          headingWidget(text: AppStrings.carPrice),
          valueTextWidget(
              headingText: AppStrings.basePrice, valueText: '£${carPostdata['price']}'),
          SizedBox(height: height(context) * 0.01),

          /// import duties
          headingWidget(text: AppStrings.importDutiesTaxes),
          valueTextWidget(
            headingText: AppStrings.duties,
            valueText: '£123',
          ),
          valueTextWidget(
            headingText: AppStrings.gst,
            valueText: '£123',
          ),
          valueTextWidget(
            headingText: AppStrings.pst,
            valueText: '£123',
          ),
          SizedBox(height: height(context) * 0.01),

          /// platform fee
          headingWidget(text: AppStrings.platformFee),
          valueTextWidget(
            headingText: AppStrings.serviceFee,
            valueText: '£123',
          ),
          SizedBox(height: height(context) * 0.01),

          /// shipment
          headingWidget(text: AppStrings.shipment),
          valueTextWidget(
            headingText: AppStrings.cargo,
            valueText: 'Estimated 30 days',
          ),
        ],
      ),
    );
  }

  Widget headingWidget({required String text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: kPadding12),
      child: Text(
        text,
        style: poppinsSemiBold.copyWith(
          color: AppColors.whiteColor,
          fontSize: kFont14,
        ),
      ),
    );
  }

  Widget valueTextWidget({
    required String headingText,
    required String valueText,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: kPadding10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headingText,
            style: poppinsMedium.copyWith(
              color: AppColors.whiteColor.withOpacity(0.6),
              fontSize: kFont12,
            ),
          ),
          Text(
            valueText,
            style: poppinsSemiBold.copyWith(
              color: AppColors.whiteOneColor,
              fontSize: kFont12,
            ),
          ),
        ],
      ),
    );
  }
}
