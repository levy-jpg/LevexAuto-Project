import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/constants.dart';

import '../../controllers/home_controller.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../home/components/car_box_widget.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  HomeController controller = Get.put(HomeController());

  loadFavData() async {
    controller.favLoading.value=true;
    await controller.getFavouriteList();
    controller.favLoading.value=false;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    loadFavData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        /// body
        appBar: const CustomAppbarWidget(
          text: 'Saved',
          autoBack: false,
        ),
        body: Obx(()=>controller.favLoading.value
            ? Container(
          height: height(context),
          width: width(context),
          color: AppColors.blackColor.withOpacity(0.2),
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        ):controller.favList.isNotEmpty
            ? GridView.builder(
                itemCount: controller.favListData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two children per row
                  crossAxisSpacing: 10.0, // Spacing between the items
                  mainAxisSpacing: 10.0,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CarBoxWidget(
                    cardata: controller.favListData[index],
                  );
                })
            : SizedBox(
                height: height(context),
                width: width(context),
                child: Center(
                  child: Text(
                    "No saved item found",
                    style: poppinsMedium.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: kFont24,
                    ),
                  ),
                ),
              )));
  }
}
