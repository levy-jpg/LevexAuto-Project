import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/app_colors.dart';
import 'package:levexauto/services/local_db.dart';
import 'package:levexauto/utils/collections.dart';
import 'package:levexauto/utils/custom_toast.dart';
import 'package:levexauto/utils/enums.dart';

class DealershipController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController registerFeeController = TextEditingController();
  Rx<DealerType> dealerType = DealerType.kenya.obs;
  Rx<SellingReason> sellingReason = SellingReason.import.obs;
  Rx<MembershipLevel> membershipLevel = MembershipLevel.platinum.obs;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void dealerSelect(DealerType type) {
    dealerType.value = type;
  }

  void sellingReasonSelect(SellingReason reason) {
    sellingReason.value = reason;
  }

  void membershipLevelSelect(MembershipLevel level) {
    membershipLevel.value = level;
  }

  /// Enum to string conversion for Firebase
  String enumToString(dynamic enumValue) {
    return enumValue.toString().split('.').last;
  }

  /// Upload dealership
  void uploadDealership() async {
    if (key.currentState!.validate()) {
      isLoading.value = true;

      String? userID = await LocalDB().getUserId();

      Map<String, dynamic> dealerData = {
        'dealerType': enumToString(dealerType.value),
        'username': usernameController.text.trim(),
        'location': locationController.text.trim(),
        'registerFee': registerFeeController.text.trim(),
        'sellingReason': enumToString(sellingReason.value),
        'membershipLevel': enumToString(membershipLevel.value),
        'userID': userID,
      };

      try {
        await _db
            .collection(DBCollections.dealership)
            .doc()
            .set(dealerData)
            .then((value) {
          isLoading.value = false;
          resetField();
          CustomToast().showToast(
            msgText: 'Dealer Profile Created Successfully',
            bgColor: AppColors.greenLightColor,
          );
        });
      } catch (e) {
        isLoading.value = false;
        CustomToast().showToast(
          msgText: 'Error : $e',
          bgColor: AppColors.primaryColor,
        );
      }
    }
  }

  /// Reset field
  void resetField() {
    usernameController.clear();
    locationController.clear();
    registerFeeController.clear();
    sellingReason.value = SellingReason.import;
    membershipLevel.value = MembershipLevel.platinum;
  }
}
