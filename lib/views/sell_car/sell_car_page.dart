import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/controllers/sell_car_controller.dart';
import 'package:levexauto/utils/enums.dart';
import 'package:levexauto/views/sell_car/components/add_image_box.dart';
import 'package:levexauto/views/sell_car/components/car_image.dart';

import '../../constants/constants.dart';
import '../../widgets/custom_overlay_widget.dart';
import '../../widgets/widgets.dart';
import 'components/selectable_widget.dart';

class SellCarPage extends StatefulWidget {
  const SellCarPage({super.key});

  @override
  State<SellCarPage> createState() => _SellCarPageState();
}

class _SellCarPageState extends State<SellCarPage> {
  @override
  Widget build(BuildContext context) {
    SellCarController controller = Get.put(SellCarController());
    return Obx(() => Scaffold(
          /// appbar
          appBar: const CustomAppbarWidget(
            text: AppStrings.sellYourCar,
            autoBack: false,
          ),

          /// body
          body: CustomOverlayWidget(
            isLoading: controller.postLoading.value,
            child: Form(
              key: controller.carPostKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: kPadding16,
                  vertical: kPadding12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// manufacture field
                    CustomTextField(
                      heading: AppStrings.manufacturer,
                      controller: controller.manufacturerController,
                      hintText: AppStrings.enterManufacturerName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a manufacturer name';
                        }
                        return null; // Return null if input is valid
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// model field
                    CustomTextField(
                      heading: AppStrings.model,
                      controller: controller.modelController,
                      hintText: AppStrings.enterModel,
                      validator: (value) {
                        if (kDebugMode) {
                          print("Validator function called with value: $value");
                        }
                        if (value!.isEmpty) {
                          return "Please enter model name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// Sell model year
                    Text(
                      AppStrings.selectModelYear,
                      style: poppinsSemiBold.copyWith(
                        color: AppColors.whiteOneColor,
                        fontSize: kFont14,
                      ),
                    ),
                    SizedBox(height: kPadding10),
                    SizedBox(
                      height: height(context) * 0.076,
                      width: width(context),
                      child: DropdownButtonFormField<String>(
                        value: controller.selectedModelYear.value.isEmpty
                            ? null
                            : controller.selectedModelYear.value,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        padding: EdgeInsets.zero,
                        // padding: EdgeInsets.symmetric(horizontal: kPadding16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadius10),
                            borderSide: const BorderSide(
                              color: AppColors.strokeColor,
                              width: 1.0,
                            ),
                            // filled: true,
                            // fillColor: AppColors.boxColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadius10),
                            borderSide: const BorderSide(
                              color: AppColors.whiteColor,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadius10),
                            borderSide: const BorderSide(
                              color: AppColors.strokeColor,
                              width: 1.0,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.boxColor,
                        ),
                        hint: Text(
                          '20**',
                          style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor.withOpacity(0.5),
                            fontSize: kFont14,
                          ),
                        ),
                        style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: kFont14,
                        ),
                        isExpanded: true,
                        dropdownColor: AppColors.boxColor,
                        onChanged: (String? newValue) {
                          controller.selectedModelYear.value = newValue!;
                          controller.update();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select a model year';
                          }
                          return null;
                        },
                        items: controller.items
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: poppinsMedium.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: kFont14,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// Select Country
                    Text(
                      AppStrings.selectCountry,
                      style: poppinsSemiBold.copyWith(
                        color: AppColors.whiteOneColor,
                        fontSize: kFont14,
                      ),
                    ),
                    SizedBox(height: kPadding10),

                    ///
                    SizedBox(
                      height: height(context) * 0.076,
                      width: width(context),
                      child: DropdownButtonFormField<String>(
                        value: controller.selectedCountry.value.isEmpty
                            ? null
                            : controller.selectedCountry.value,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        padding: EdgeInsets.zero,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadius10),
                            borderSide: const BorderSide(
                              color: AppColors.strokeColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadius10),
                            borderSide: const BorderSide(
                              color: AppColors.whiteColor,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(kRadius10),
                            borderSide: const BorderSide(
                              color: AppColors.strokeColor,
                              width: 1.0,
                            ),
                          ),
                          filled: true,
                          fillColor: AppColors.boxColor,
                        ),
                        hint: Text(
                          'UK',
                          style: poppinsMedium.copyWith(
                            color: AppColors.whiteColor.withOpacity(0.5),
                            fontSize: kFont14,
                          ),
                        ),
                        style: poppinsMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: kFont14,
                        ),
                        isExpanded: true,
                        dropdownColor: AppColors.boxColor,
                        onChanged: (String? newValue) {
                          controller.selectedCountry.value = newValue!;
                          controller.update();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select country';
                          }
                          return null;
                        },
                        items: controller.countries
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: poppinsMedium.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: kFont14,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// location field
                    CustomTextField(
                      heading: AppStrings.location,
                      controller: controller.locationController,
                      hintText: AppStrings.yourLocation,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          controller.postLoading.value = true;
                          await controller.getLocation();
                          controller.postLoading.value = false;
                        },
                        icon: SvgPicture.asset(AppIcons.location),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null; // Return null if input is valid
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// car condition
                    Text(
                      AppStrings.condition,
                      style: poppinsSemiBold.copyWith(
                        color: AppColors.whiteOneColor,
                        fontSize: kFont14,
                      ),
                    ),
                    SizedBox(height: kPadding10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SelectableWidget(
                            onTap: () {
                              controller
                                  .conditionSelectFun(CarCondition.newCar);
                            },
                            text: 'New',
                            isActive: controller.condition.value ==
                                CarCondition.newCar,
                          ),
                        ),
                        SizedBox(width: height(context) * 0.016),
                        Expanded(
                          child: SelectableWidget(
                            onTap: () {
                              controller.conditionSelectFun(CarCondition.used);
                            },
                            text: 'Used',
                            isActive:
                                controller.condition.value == CarCondition.used,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height(context) * 0.02),

                    /// vehicle history
                    CustomTextField(
                      heading: AppStrings.vehicleHistory,
                      controller: controller.vehicleHistoryController,
                      hintText: 'Enter Vehicle history',
                      minLines: 4,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a vehicle history';
                        }
                        return null; // Return null if input is valid
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// specifications
                    CustomTextField(
                      heading: AppStrings.specifications,
                      controller: controller.specificationsController,
                      hintText: 'Enter vehicle specifications',
                      minLines: 4,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter vehicle specifications';
                        }
                        return null; // Return null if input is valid
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// other descriptions
                    CustomTextField(
                      heading: AppStrings.otherDescriptions,
                      controller: controller.otherDescController,
                      hintText: 'Enter other description',
                      minLines: 4,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter other description';
                        }
                        return null; // Return null if input is valid
                      },
                    ),
                    SizedBox(height: height(context) * 0.02),

                    /// add image
                    Text(
                      AppStrings.addImages,
                      style: poppinsSemiBold.copyWith(
                        color: AppColors.whiteOneColor,
                        fontSize: kFont14,
                      ),
                    ),
                    SizedBox(height: kPadding16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AddImageBox(onTap: () {
                          controller.getGalleryImage();
                          controller.update();
                        }),
                        SizedBox(
                          width: width(context) * 0.625,
                          height: height(context) * 0.125,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.vehicleImages.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) =>
                                CarImage(
                                    imagePath: controller.vehicleImages[index]
                                        ['path'],
                                    onDeleteTap: () {
                                      if (kDebugMode) {
                                        print(" Hrer is the data ");
                                      }
                                      controller.vehicleImages.remove(
                                          controller.vehicleImages[index]);
                                      controller.update();
                                    }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height(context) * 0.024),

                    /// Sell Type & Price

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.sellTypePrice,
                          style: poppinsSemiBold.copyWith(
                            color: AppColors.whiteOneColor,
                            fontSize: kFont14,
                          ),
                        ),
                        SizedBox(height: kPadding10),

                        ///
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SelectableWidget(
                                onTap: () {
                                  controller.sellTypeFun(SellType.fixed);
                                },
                                text: AppStrings.fixedPrice,
                                isActive:
                                    controller.sellType.value == SellType.fixed,
                              ),
                            ),
                            SizedBox(width: height(context) * 0.016),
                            Expanded(
                              child: SelectableWidget(
                                onTap: () {
                                  controller.sellTypeFun(SellType.bidding);
                                },
                                text: AppStrings.bidding,
                                isActive: controller.sellType.value ==
                                    SellType.bidding,
                              ),
                            ),
                          ],
                        ),
                        controller.sellType.value == SellType.fixed
                            ? SizedBox(height: height(context) * 0.024)
                            : const SizedBox(),
                        controller.sellType.value == SellType.fixed
                            ? TextFormField(
                                keyboardType: TextInputType.number,
                                style: poppinsMedium.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: kFont14,
                                ),
                                controller: controller.addPriceController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.boxColor,
                                  hintText: AppStrings.addPrice,
                                  hintStyle: poppinsMedium.copyWith(
                                    color:
                                        AppColors.whiteColor.withOpacity(0.5),
                                    fontSize: kFont14,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kPadding16,
                                    vertical: kPadding14,
                                  ),
                                  suffixText: '£161,000',
                                  suffixStyle: poppinsMedium.copyWith(
                                    color:
                                        AppColors.whiteColor.withOpacity(0.5),
                                    fontSize: kFont16,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kRadius10),
                                    borderSide: const BorderSide(
                                      color: AppColors.strokeColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kRadius10),
                                    borderSide: const BorderSide(
                                      color: AppColors.strokeColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kRadius10),
                                    borderSide: const BorderSide(
                                      color: AppColors.strokeColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a username';
                                  }
                                  return null; // Return null if input is valid
                                },
                              )
                            : const SizedBox(),
                      ],
                    ),

                    /// button
                    SizedBox(height: height(context) * 0.06),
                    CustomButton(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await controller.postCar();
                      },
                      buttonText: AppStrings.createPost,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
