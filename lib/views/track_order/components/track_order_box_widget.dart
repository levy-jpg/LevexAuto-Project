import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/constants.dart';
import '../../../widgets/widgets.dart';
import '../../order_recipts/Component/recieptWidget.dart';
import '../track_order_data_page.dart';

class TrackOrderBoxWidget extends StatelessWidget {
  var trackingData;

  TrackOrderBoxWidget({super.key, required this.trackingData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      padding: EdgeInsets.all(kPadding16),
      margin: EdgeInsets.symmetric(horizontal: kPadding16),
      decoration: BoxDecoration(
        color: AppColors.primaryOneColor,
        borderRadius: BorderRadius.circular(kRadius10),
        border: Border.all(
          color: AppColors.strokeColor,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// car and order details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height(context) * 0.08,
                width: height(context) * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadius12),
                  image:  DecorationImage(
                    image: NetworkImage(trackingData['image']),
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
                      '${trackingData['carName']}',
                      style: poppinsMedium.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: kFont16,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      '${trackingData['modelYear']}',
                      style: poppinsRegular.copyWith(
                        color: AppColors.greyLightColor,
                        fontSize: kFont14,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '#${trackingData['trackingId']}',
                style: poppinsRegular.copyWith(
                  color: AppColors.greenLightColor,
                  fontSize: kFont10,
                ),
              ),
            ],
          ),
          SizedBox(height: height(context) * 0.016),

          /// date and status
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.estimatedArrival,
                style: poppinsRegular.copyWith(
                  color: AppColors.greyLightColor,
                  fontSize: kFont12,
                ),
              ),
              Text(
                AppStrings.status,
                style: poppinsRegular.copyWith(
                  color: AppColors.greyLightColor,
                  fontSize: kFont12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMd().format(trackingData['pickUpDate'].toDate()),
                style: poppinsMedium.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: kFont14,
                ),
              ),
              Text(
                trackingData['status'] == "inProgress"
                    ? 'On the Way'
                    : "Delivered",
                style: poppinsMedium.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: kFont14,
                ),
              ),
            ],
          ),
          SizedBox(height: height(context) * 0.016),

          /// divider
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: AppColors.whiteOneColor.withOpacity(0.1),
          ),
          SizedBox(height: height(context) * 0.012),

          /// buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Get.to(ReceiptWidget(
                      carPostData:trackingData ,
                    ));
                  },
                  buttonText: AppStrings.viewDetails,
                  radius: kRadius10,
                  buttonColor: AppColors.whiteColor.withOpacity(0.05),
                  borderColor: AppColors.whiteColor.withOpacity(0.02),
                  fontSize: kFont14,
                ),
              ),
              SizedBox(width: height(context) * 0.016),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Get.to(TrackOrderDataPage(
                      trackingData: trackingData,
                    ));
                  },
                  buttonText: AppStrings.trackOrder,
                  radius: kRadius10,
                  fontSize: kFont14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
