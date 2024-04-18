import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/widgets/widgets.dart';
import '../../controllers/countdown_controller.dart';
import '../../utils/custom_toast.dart';
import 'components/countdown_widget.dart';

class BidPage extends StatefulWidget {
  var carPostData;

  BidPage({super.key, required this.carPostData});

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> {
  CountdownController controller = Get.put(CountdownController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /// appbar
      appBar: const CustomAppbarWidget(text: AppStrings.placeYourBid),

      /// body
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.carPostData.id)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final cardata = snapshot.data!;
          return SingleChildScrollView(
            child: Form(
              key: controller.bidKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// car model and number
                        SizedBox(height: height(context) * 0.01),
                        Text(
                          '${cardata['manufacture']} ${cardata['model']} (${cardata['modelYear']})',
                          style: poppinsBold.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: kFont22,
                          ),
                        ),

                        /// price
                        SizedBox(height: height(context) * 0.015),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                '\$${cardata['price']}',
                                style: poppinsRegular.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: kFont16,
                                ),
                              ),
                            ),
                            Container(
                              height: 12,
                              width: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.greenDarkColor,
                              ),
                            ),
                          ],
                        ),

                        /// countdown widget
                        SizedBox(height: height(context) * 0.04),
                        const CountdownWidget(),

                        /// highest bid
                        SizedBox(height: height(context) * 0.03),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.highestBid,
                              style: poppinsMedium.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: kFont18,
                              ),
                            ),
                            Text(
                              ' \$${cardata['price']}',
                              style: poppinsMedium.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: kFont18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          AppStrings.youNeedToPlaceABidHigherThanThis,
                          style: poppinsRegular.copyWith(
                            color: AppColors.whiteColor.withOpacity(0.6),
                            fontSize: kFont14,
                          ),
                        ),

                        /// divider
                        SizedBox(height: height(context) * 0.03),
                        Divider(
                          color: AppColors.whiteColor.withOpacity(0.1),
                          height: 1.0,
                          thickness: 1.0,
                        ),

                        /// my bid
                        SizedBox(height: height(context) * 0.03),
                        Text(
                          AppStrings.myBid,
                          style: poppinsBold.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: kFont20,
                          ),
                        ),

                        /// your bid
                        SizedBox(height: height(context) * 0.02),
                        Text(
                          AppStrings.enterYourBid,
                          style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: kFont16,
                          ),
                        ),
                        SizedBox(height: height(context) * 0.01),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: controller.bidController,
                          style: poppinsRegular.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: kFont16,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.whiteTwoColor.withOpacity(0.2),
                            contentPadding: EdgeInsets.all(kPadding16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius12),
                              borderSide: BorderSide(
                                color: AppColors.whiteTwoColor.withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius12),
                              borderSide: BorderSide(
                                color: AppColors.whiteTwoColor.withOpacity(0.2),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kRadius12),
                              borderSide: BorderSide(
                                color: AppColors.whiteTwoColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                          validator: (val){
                            if(val!.isEmpty){
                              return "Please enter your bid";
                            }else if(int.parse(val)<int.parse(cardata['price'])){
                              return "Increase your bid";
                            }
                            return null;
                          },
                        ),

                        ///
                        SizedBox(height: height(context) * 0.03),
                        Obx(
                          () {
                            final duration = controller.timeLeft.value;
                            String twoDigits(int n) => n.toString().padLeft(2, '0');
                            final minutes =
                                twoDigits(duration.inMinutes.remainder(60));
                            final seconds =
                                twoDigits(duration.inSeconds.remainder(60));
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.auctionEndsIn,
                                  style: poppinsRegular.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: kFont14,
                                  ),
                                ),
                                Text(
                                  ' $minutes minutes and $seconds seconds',
                                  style: poppinsRegular.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: kFont14,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  /// button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding16),
                    child: CustomButton(
                      onTap: () async {
                        if(int.parse(controller.bidController.text)>int.parse(cardata['price'])){
                          await controller.biding(cardata.id, controller.bidController.text.trim());
                          controller.bidController.clear();
                        }else{
                          CustomToast().showToast(
                            msgText: 'Increase Bid price',
                          );
                        }

                      },
                      buttonText: AppStrings.placeYourBid,
                    ),
                  ),
                  SizedBox(height: height(context) * 0.03),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
