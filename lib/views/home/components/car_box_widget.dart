import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';
import 'package:levexauto/views/home/components/bookmark_widget.dart';
import 'package:levexauto/views/home/pages/car_details_page.dart';

class CarBoxWidget extends StatelessWidget {
  var cardata;

  CarBoxWidget({super.key, this.cardata});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to( CarDetailsPage(carPostData: cardata,));
      },
      child: Container(
        height: height(context) * 0.24,
        width: height(context) * 0.2,
        margin: EdgeInsets.only(right: height(context) * 0.016),
        decoration: BoxDecoration(
          color: AppColors.whiteColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(kRadius5),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height(context) * 0.12,
                  width: width(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kRadius5),
                      topRight: Radius.circular(kRadius5),
                    ),
                    image: DecorationImage(
                      image: NetworkImage('${cardata['images'].first}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                 Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: BookmarkWidget(
                    postId: cardata.id,
                  ),
                ),
              ],
            ),
            SizedBox(height: height(context) * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPadding10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${cardata['manufacture']} ${cardata['model']}',
                    style: poppinsMedium.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: kFont12,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.location,
                        height: 14,
                      ),
                      const SizedBox(width: 3.0),
                      Flexible(
                        child: Text(
                          '${cardata['address']}',
                          maxLines: 1,
                          style: poppinsRegular.copyWith(
                            color: AppColors.whiteOneColor.withOpacity(0.6),
                            fontSize: kFont10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height(context) * 0.01),
                  cardata['sellType'] == "Bid"
                      ? Text(
                          'Biding',
                          style: poppinsSemiBold.copyWith(
                            color: AppColors.whiteOneColor,
                            fontSize: kFont14,
                          ),
                        )
                      : Text(
                          '£${cardata['price']}',
                          style: poppinsSemiBold.copyWith(
                            color: AppColors.whiteOneColor,
                            fontSize: kFont14,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
