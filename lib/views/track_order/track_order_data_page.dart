import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/widgets/widgets.dart';

import 'components/order_data_box_widget.dart';

class TrackOrderDataPage extends StatelessWidget {
  var trackingData;
  int calculateDifference(orderDateString) {
    DateTime currentDate = DateTime.now();
    // Calculate the difference in days
    final difference = currentDate.difference(orderDateString).inDays;
    print(" here is differe ${difference}");
    return difference;
  }
  TrackOrderDataPage({super.key, required this.trackingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.trackOrder),

      /// body
      body: ListView(
        padding: EdgeInsets.all(kPadding16),
        children: [
          /// heading
          Text(
            AppStrings.estimatedArrival,
            style: poppinsSemiBold.copyWith(
              color: AppColors.whiteColor,
              fontSize: kFont16,
            ),
          ),
          SizedBox(height: height(context) * 0.016),

          /// indicator
          Stack(
            children: [
              Container(
                height: 10,
                width: width(context),
                decoration: BoxDecoration(
                  color: AppColors.whiteOneColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(kRadius10),
                ),
              ),
              Container(
                height: 10,
                width: width(context)*(calculateDifference(trackingData['orderDate'].toDate())/23),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(kRadius10),
                ),
              ),
            ],
          ),
          SizedBox(height: height(context) * 0.01),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'in 23 days',
                style: poppinsMedium.copyWith(
                  color: AppColors.whiteOneColor,
                  fontSize: kFont12,
                ),
              ),
              Text(
                '${((calculateDifference(trackingData['orderDate'].toDate()))/23*100).toStringAsFixed(2)}%',
                style: poppinsMedium.copyWith(
                  color: AppColors.whiteOneColor,
                  fontSize: kFont12,
                ),
              ),
            ],
          ),

          ///
          SizedBox(height: height(context) * 0.024),
          OrderDataBoxWidget(
            trackingId: trackingData['trackingId'],
            address: '${trackingData['address']['address']}',
          ),

          /// timeline
          SizedBox(height: height(context) * 0.024),
          Text(
            AppStrings.timeline,
            style: poppinsSemiBold.copyWith(
              color: AppColors.whiteColor,
              fontSize: kFont16,
            ),
          ),

          /// timeline
          SizedBox(height: height(context) * 0.02),
          MyTimeLineWidget(
            titleText: AppStrings.orderPlaced,
            valueText: DateFormat.yMMMd().format(trackingData['orderDate'].toDate()),
            isCompleted:calculateDifference(trackingData['orderDate'].toDate())>=2?true:false,
            // true,
          ),
          MyTimeLineWidget(
            titleText: AppStrings.pickedUpFromDealer,
            valueText: DateFormat.yMMMd().format(trackingData['orderDate'].toDate().add(const Duration(days: 2))),
            isActive: calculateDifference(trackingData['orderDate'].toDate())>=2?true:false,
            isCompleted: calculateDifference(trackingData['orderDate'].toDate())>=9?true:false,
          ),
          MyTimeLineWidget(
            titleText: AppStrings.arrivedAtPort,
            valueText: DateFormat.yMMMd().format(trackingData['orderDate']
                .toDate()
                .add(const Duration(days: 9))),
            isActive: calculateDifference(trackingData['orderDate'].toDate())>=9?true:false,
            isCompleted: calculateDifference(trackingData['orderDate'].toDate())>=16?true:false,
          ),
          MyTimeLineWidget(
            titleText: AppStrings.shipDeparts,
            valueText: DateFormat.yMMMd().format(trackingData['orderDate']
                .toDate()
                .add(const Duration(days: 16))),
            isActive: calculateDifference(trackingData['orderDate'].toDate())>=16?true:false,
            isCompleted: calculateDifference(trackingData['orderDate'].toDate())>=23?true:false,
          ),
          MyTimeLineWidget(
            titleText: AppStrings.arrivedAtLA,
            valueText: DateFormat.yMMMd().format(trackingData['orderDate']
                .toDate()
                .add(const Duration(days: 23))),
            isActive: calculateDifference(trackingData['orderDate'].toDate())>=23?true:false,
            isLast: true
          ),
        ],
      ),
    );
  }
}
