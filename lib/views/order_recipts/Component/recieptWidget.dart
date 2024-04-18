import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../widgets/custom_appbar_widget.dart';
import '../../home/components/car_data_widget.dart';
import '../../home/components/car_slider_widget.dart';
import '../../home/components/price_text_widget.dart';

class ReceiptWidget extends StatefulWidget {
  var carPostData;

  ReceiptWidget({super.key, this.carPostData});

  @override
  State<ReceiptWidget> createState() => _ReceiptWidgetState();
}

class _ReceiptWidgetState extends State<ReceiptWidget> {
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchData() async {
    print("here os doc isads${widget.carPostData['postId']}");
    var result = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.carPostData['postId'])
        .get();
    await Future.delayed(const Duration(seconds: 2));
    return result!; // Simulated fetched data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.orderReceipt),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(), // Loading indicator
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'), // Error message
            );
          } else {
            var carData = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// image slider
                  CarSliderWidget(
                    imagesData: carData['images'],
                    postId: carData.id,
                  ),
                  SizedBox(height: kPadding20),

                  /// name price year & location
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${carData['manufacture']} ${carData['model']}',
                                style: poppinsSemiBold.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: kFont18,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                '${carData['modelYear']}',
                                style: poppinsMedium.copyWith(
                                  color: AppColors.whiteOneColor.withOpacity(0.6),
                                  fontSize: kFont14,
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.location,
                                    height: 14,
                                    color: AppColors.whiteOneColor.withOpacity(0.6),
                                  ),
                                  const SizedBox(width: 3.0),
                                  Text(
                                    '${widget.carPostData['address']['address']}',
                                    style: poppinsRegular.copyWith(
                                      color:
                                      AppColors.whiteOneColor.withOpacity(0.6),
                                      fontSize: kFont10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '£${widget.carPostData['totalPrice']}',
                          style: poppinsSemiBold.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: kFont24,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height(context) * 0.024),

                  /// car data
                  CarDataWidget(
                    iconUrl: AppIcons.menufecture,
                    headingText: AppStrings.manufacturer,
                    valueText: '${carData['manufacture']}',
                  ),
                  CarDataWidget(
                    iconUrl: AppIcons.modelYear,
                    headingText: AppStrings.modelYear,
                    valueText: '${carData['modelYear']}',
                  ),
                  CarDataWidget(
                    iconUrl: AppIcons.specs,
                    headingText: AppStrings.specs,
                    valueText: '${carData['specifications']}',
                  ),
                  CarDataWidget(
                    iconUrl: AppIcons.history,
                    headingText: AppStrings.history,
                    valueText: '${carData['vehicleHistory']}',
                  ),

                  /// divider
                  SizedBox(height: height(context) * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    child: Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: AppColors.whiteColor.withOpacity(0.05),
                    ),
                  ),
                  SizedBox(height: height(context) * 0.015),

                  /// description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    child: Text(
                      AppStrings.description,
                      style: poppinsSemiBold.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: kFont14,
                      ),
                    ),
                  ),
                  SizedBox(height: height(context) * 0.01),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    child: ReadMoreText(
                      '${carData['description']}',
                      trimLines: 3,
                      colorClickableText: AppColors.primaryColor,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Read more',
                      trimExpandedText: 'Read less',
                      style: poppinsMedium.copyWith(
                        color: AppColors.whiteOneColor.withOpacity(0.6),
                        fontSize: kFont12,
                      ),
                      moreStyle: poppinsMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: kFont12,
                      ),
                    ),
                  ),

                  /// divider
                  SizedBox(height: height(context) * 0.015),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    child: Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: AppColors.whiteColor.withOpacity(0.05),
                    ),
                  ),
                  SizedBox(height: height(context) * 0.02),

                  /// price breakdown widget
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    child: Text(
                      AppStrings.priceBreakdown,
                      style: poppinsSemiBold.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: kFont14,
                      ),
                    ),
                  ),
                  SizedBox(height: height(context) * 0.016),
                  PriceTextWidget(
                    titleText: AppStrings.basePrice,
                    valueText: '£${carData['price']}',
                  ),
                  Column(
                    children: [
                      /// taxation
                      PriceTextWidget(
                        titleText: AppStrings.taxation,
                        valueText:
                        '£${widget.carPostData['IDF'] + widget.carPostData['RDL'] + widget.carPostData['exciseDuty'] + widget.carPostData['vat']}',
                      ),

                      /// import fee
                      PriceTextWidget(
                        titleText: AppStrings.importFees,
                        valueText: '£${widget.carPostData['importFee']}',
                      ),
                    ],
                  ),

                  /// platform cost
                  PriceTextWidget(
                    titleText: AppStrings.platformCost,
                    valueText: '£${widget.carPostData['platFormFee']}',
                  ),

                  /// delivery time
                  const PriceTextWidget(
                    titleText: AppStrings.deliveryTime,
                    valueText: '2 months',
                  ),
                  SizedBox(height: height(context) * 0.1),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
