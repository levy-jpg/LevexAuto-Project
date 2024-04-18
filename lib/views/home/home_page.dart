import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/controllers/home_controller.dart';
import '../../constants/constants.dart';
import '../../controllers/profile_controller.dart';
import '../track_order/components/track_order_box_widget.dart';
import 'components/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());
  ProfileController profileController = Get.put(ProfileController());

  var firstLoading = false;

  var isSearching = false;

  loadData() {
    firstLoading = true;
    setState(() {});
    controller.getData();
    firstLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('here is the contry ${controller.sellCarController.country}');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        /// body
        body: firstLoading
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
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// search field
                  SizedBox(height: height(context) * 0.02),
                  SearchCarWidget(
                    controller: controller.searchCarController,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        isSearching = true;
                        setState(() {});
                        controller.searching(
                            controller.searchCarController.text.trim());
                      } else {
                        isSearching = false;
                        setState(() {});
                      }
                    },
                    onFilterTap: () {
                      controller.searching(
                          controller.searchCarController.text.trim());
                    },
                  ),

                  ///
                  isSearching
                      ? Obx(
                          () => Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                vertical: kPadding20,
                              ),
                              child: Column(
                                children: [
                                  controller.searchLoading.value
                                      ? Container(
                                          height: height(context) * 0.2,
                                          width: width(context),
                                          color: AppColors.blackColor
                                              .withOpacity(0.2),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        )
                                      : controller.searchingResult.isNotEmpty
                                          ? GridView.builder(
                                              itemCount: controller
                                                  .searchingResult.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    2, // Two children per row
                                                crossAxisSpacing:
                                                    10.0, // Spacing between the items
                                                mainAxisSpacing: 10.0,
                                              ),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return CarBoxWidget(
                                                  cardata: controller
                                                      .searchingResult[index],
                                                );
                                              })
                                          : SizedBox(
                                              height: height(context) * 0.6,
                                              width: width(context),
                                              child: Center(
                                                child: Text(
                                                  'No Result Found',
                                                  style: poppinsMedium.copyWith(
                                                    color: AppColors.whiteColor,
                                                    fontSize: kFont24,
                                                  ),
                                                ),
                                              ),
                                            )
                                ],
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: kPadding20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// recommended for you  data
                                  Obx(
                                    () => profileController
                                            .trackingOrders.isEmpty
                                        ? const SizedBox()
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// texts
                                              const HeadingTextWidget(
                                                  text: AppStrings
                                                      .trackYourOrder),

                                              /// track order box widget
                                              SizedBox(
                                                  height:
                                                      height(context) * 0.02),
                                              TrackOrderBoxWidget(
                                                trackingData: profileController
                                                    .trackingOrders.first,
                                              ),
                                            ],
                                          ),
                                  ),

                                  /// recommended text
                                  SizedBox(height: height(context) * 0.024),
                                  const HeadingTextWidget(
                                      text: AppStrings.recommendedForYou),

                                  /// car items stream builder is here
                                  SizedBox(height: height(context) * 0.02),
                                  SizedBox(
                                    height: height(context) * 0.23,
                                    child: StreamBuilder<
                                        List<DocumentSnapshot<Object?>>>(
                                      stream: controller.recommendedPost(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: Container(
                                              height: height(context),
                                              width: width(context),
                                              color: AppColors.blackColor
                                                  .withOpacity(0.2),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ), // Show loader while loading data
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'), // Handle error state
                                          );
                                        } else if (snapshot.data!.isEmpty) {
                                          return Center(
                                            child: Text(
                                              'No data available',
                                              style: poppinsRegular.copyWith(
                                                color: AppColors.whiteColor,
                                                fontSize: kFont14,
                                              ),
                                            ), // Handle empty data state
                                          );
                                        } else {
                                          return ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: kPadding16),
                                            itemBuilder: (context, index) {
                                              return CarBoxWidget(
                                                cardata: snapshot.data![index],
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                  /// car in kenya
                                  SizedBox(height: height(context) * 0.024),
                                  const HeadingTextWidget(
                                      text: AppStrings.carsInKenya),

                                  /// car items
                                  SizedBox(height: height(context) * 0.02),
                                  Obx(() => SizedBox(
                                      height: height(context) * 0.23,
                                      child: controller.loadingData.value
                                          ? Container(
                                              height: height(context),
                                              width: width(context),
                                              color: AppColors.blackColor
                                                  .withOpacity(0.2),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            )
                                          : controller.kenyaData.isNotEmpty
                                              ? ListView.builder(
                                                  itemCount: controller
                                                      .kenyaData.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: kPadding16),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CarBoxWidget(
                                                      cardata: controller
                                                          .kenyaData[index],
                                                    );
                                                  },
                                                )
                                              : Center(
                                                  child: Text(
                                                  'No car found',
                                                  style:
                                                      poppinsRegular.copyWith(
                                                    color: AppColors.whiteColor,
                                                    fontSize: kFont14,
                                                  ),
                                                )))),

                                  /// car in UK
                                  SizedBox(height: height(context) * 0.024),
                                  const HeadingTextWidget(
                                      text: AppStrings.carsInUK),

                                  /// car items
                                  SizedBox(height: height(context) * 0.02),
                                  Obx(() => SizedBox(
                                        height: height(context) * 0.23,
                                        child: controller.loadingData.value
                                            ? Container(
                                                height: height(context),
                                                width: width(context),
                                                color: AppColors.blackColor
                                                    .withOpacity(0.2),
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                              )
                                            : controller
                                                    .uKCarPostData.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount: controller
                                                        .uKCarPostData.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                kPadding16),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return CarBoxWidget(
                                                        cardata: controller
                                                                .uKCarPostData[
                                                            index],
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child: Text(
                                                    'No car found',
                                                    style:
                                                        poppinsRegular.copyWith(
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontSize: kFont14,
                                                    ),
                                                  )),
                                      )),
                                  SizedBox(height: height(context) * 0.1),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
