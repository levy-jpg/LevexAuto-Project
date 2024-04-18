import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/widgets/widgets.dart';

import '../../../controllers/sell_car_controller.dart';
import '../../../controllers/shipping_controller.dart';
import '../../order_place/payment_select_page.dart';
import '../components/index.dart';
import '../../bid/bid_page.dart';

class CarDetailsPage extends StatelessWidget {
  var carPostData;

  CarDetailsPage({super.key, required this.carPostData});

  SellCarController controller = Get.put(SellCarController());
  ShippingController shippingController = Get.put(ShippingController());

  @override
  Widget build(BuildContext context) {
    shippingController.calculateDepreciation(
        int.parse(carPostData['modelYear']),
        double.parse(carPostData['price']));
    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.carDetails),
      /// body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// car data
          Expanded(
            child: ListView(
              children: [
                /// image slider
                CarSliderWidget(
                  imagesData: carPostData['images'],
                  postId: carPostData.id,
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
                              '${carPostData['manufacture']} ${carPostData['model']}',
                              style: poppinsSemiBold.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: kFont18,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              '${carPostData['modelYear']}',
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
                                  color:
                                      AppColors.whiteOneColor.withOpacity(0.6),
                                ),
                                const SizedBox(width: 3.0),
                                Text(
                                  '${carPostData['address']}',
                                  style: poppinsRegular.copyWith(
                                    color: AppColors.whiteOneColor
                                        .withOpacity(0.6),
                                    fontSize: kFont10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .doc(carPostData.id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              '£${carPostData['price']}',
                              style: poppinsSemiBold.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kFont24,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text(
                              '£${carPostData['price']}',
                              style: poppinsSemiBold.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kFont24,
                              ),
                            );
                          }
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return Text(
                              '£${snapshot.data!['price']}',
                              style: poppinsSemiBold.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: kFont24,
                              ),
                            );
                          }
                          return Text(
                            '£${snapshot.data!['price']}',
                            style: poppinsSemiBold.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: kFont24,
                            ),
                          );
                          ;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height(context) * 0.024),

                /// car data
                CarDataWidget(
                  iconUrl: AppIcons.menufecture,
                  headingText: AppStrings.manufacturer,
                  valueText: '${carPostData['manufacture']}',
                ),
                CarDataWidget(
                  iconUrl: AppIcons.modelYear,
                  headingText: AppStrings.modelYear,
                  valueText: '${carPostData['modelYear']}',
                ),
                CarDataWidget(
                  iconUrl: AppIcons.specs,
                  headingText: AppStrings.specs,
                  valueText: '${carPostData['specifications']}',
                ),
                CarDataWidget(
                  iconUrl: AppIcons.history,
                  headingText: AppStrings.history,
                  valueText: '${carPostData['vehicleHistory']}',
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
                    '${carPostData['description']}',
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
                  valueText: '£${carPostData['price']}',
                ),
                controller.country != carPostData['country']
                    ? Column(
                        children: [
                          /// taxation
                          PriceTextWidget(
                            titleText: AppStrings.taxation,
                            valueText: '£${shippingController.taxation.value}',
                          ),

                          /// import fee
                          PriceTextWidget(
                            titleText: AppStrings.importFees,
                            valueText:
                                '£${shippingController.importDuty.value}',
                          ),
                        ],
                      )
                    : const SizedBox(),

                /// platform cost
                PriceTextWidget(
                  titleText: AppStrings.platformCost,
                  valueText: '£${shippingController.platFormFee.value}',
                ),

                /// delivery time
                const PriceTextWidget(
                  titleText: AppStrings.deliveryTime,
                  valueText: '2 months',
                ),

                if (carPostData['sellType'] == "Bid")

                  /// buttons
                  SizedBox(height: height(context) * 0.06),
                carPostData['sellType'] == "Bid"
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: kPadding16),
                        child: CustomButton(
                          onTap: () {
                            Get.to(BidPage(
                              carPostData: carPostData,
                            ));
                          },
                          buttonText: AppStrings.placeYourBid,
                        ),
                      )
                    : const SizedBox(),
                SizedBox(height: height(context) * 0.02),
                carPostData['sellType'] == "Bid"
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: kPadding16),
                        child: CustomButton(
                          onTap: () {
                            Get.to(PaymentSelectPage(
                              carPostData: carPostData,
                            ));
                          },
                          buttonText: AppStrings.purchaseCar,
                        ),
                      ),

                SizedBox(height: height(context) * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
