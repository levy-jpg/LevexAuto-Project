import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:levexauto/utils/collections.dart';

import '../services/local_db.dart';
import '../utils/custom_toast.dart';
import 'home_controller.dart';

class ShippingController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  var addressController1 = TextEditingController().obs;
  var cityController1 = TextEditingController().obs;
  var countryController1 = TextEditingController().obs;
  var stateController1 = TextEditingController().obs;
  var postalCodeController1 = TextEditingController().obs;
  RxBool isLoading = false.obs;
  HomeController homeController = Get.put(HomeController());
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  GlobalKey<FormState> addAddressKey = GlobalKey<FormState>();
  var loading = false.obs;
  var shippingAddresses = [].obs;
  var selectedAddress = 0.obs;
  var customsValue=0.0.obs;
  var importDuty=0.0.obs;
  var exciseDuty=0.0.obs;
  var vat=0.0.obs;
  var iDF=0.0.obs;
  var rDl=0.0.obs;
  var taxation=0.0.obs;
  var totalPrice=0.0.obs;
  var platFormFee=0.0.obs;
  var purchaseLoading=false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getShippingAddress();
    update();
  }

  /// function for adding address
  addShippingAddress() async {
    var userId = await LocalDB().getUserId();
    if (addAddressKey.currentState!.validate()) {
      try {
        loading.value = true;
        Map<String, dynamic> shippingAddress = {
          'address': addressController.text.trim(),
          'city': cityController.text.trim(),
          'country': countryController.text.trim(),
          'state': stateController.text.trim(),
          'postcode': postalCodeController.text.trim(),
        };
        await _db.collection(DBCollections.users).doc('$userId').update({
          'shippingAddresses': FieldValue.arrayUnion([shippingAddress]),
        });
        CustomToast().showToast(
          msgText: "Address added successfully",
        );
        getShippingAddress();
        Get.back();
        loading.value = false;
      } catch (e) {
        loading.value = false;
        CustomToast().showToast(
          msgText: e.toString(),
        );
      }
    } else {}
  }

  /// get Shipping address
  getShippingAddress() async {
    loading.value = true;
    var userId = await LocalDB().getUserId();
    final snapshot =
        await _db.collection(DBCollections.users).doc(userId).get();
    final data = snapshot.data();
    final addresses = data!['shippingAddresses'] ?? [];
    shippingAddresses.value = addresses;
    loading.value = false;
  }

  updateSelectedAddress(index) {
    selectedAddress.value = index;
  }

  /// generating random id
  String generateCustomId() {
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var random = Random().nextInt(1000);
    return '$timestamp$random';
  }
  /// Function to calculate depreciation
  double calculateDepreciation(int modelYear, double crsp) {
     customsValue=0.0.obs;
     importDuty=0.0.obs;
     exciseDuty=0.0.obs;
     vat=0.0.obs;
     iDF=0.0.obs;
     rDl=0.0.obs;
     taxation=0.0.obs;
     totalPrice=0.0.obs;
     platFormFee=0.0.obs;
     update();
    int currentYear = DateTime.now().year;
    int age = currentYear - modelYear;
    double depreciationRate = 0.10; // 10% annual depreciation rate

     customsValue.value = crsp;

    // Apply depreciation for each year
    for (int i = 0; i < age; i++) {
      customsValue.value -= (customsValue.value * depreciationRate);
    }
     importDuty.value =(customsValue.value/100*35).roundToDouble();
      platFormFee.value=crsp/100*10;
     exciseDuty.value=(customsValue.value+importDuty.value)/100*20;
     vat.value=(customsValue.value+importDuty.value+exciseDuty.value)/100*16;
     iDF.value=customsValue.value/100*3.5;
     rDl.value=customsValue.value/100*2;
     taxation.value=(rDl.value+iDF.value+vat.value+exciseDuty.value).roundToDouble();
     totalPrice.value=(taxation.value+importDuty.value+crsp+platFormFee.value).roundToDouble();
     update();
    return customsValue.value;
  }
  /// purchase car function here
  purchaseCar({postData}) async {
    var userId = await LocalDB().getUserId();
    var trackingID = generateCustomId();
    DateTime currentDate = DateTime.now();
    DateTime futureDate = currentDate.add(const Duration(days: 20));
    Map<String, dynamic> orderDetail = {
      'address': shippingAddresses[selectedAddress.value],
      'trackingId': trackingID,
      'userId': userId,
      'orderDate': DateTime.now(),
      'pickUpDate': futureDate,
      'shippingMethod': 'Cargo',
      'postId': postData.id,
      'status': 'inProgress',
      'totalPrice':totalPrice.value.roundToDouble(),
      'vat':vat.value.roundToDouble(),
      'exciseDuty':exciseDuty.value.roundToDouble(),
      'importFee':importDuty.value.roundToDouble(),
      'IDF':iDF.value.roundToDouble(),
      'RDL':rDl.value.roundToDouble(),
      'image': postData['images'].first,
      'platFormFee':platFormFee.value.roundToDouble(),
      'carName': '${postData['manufacture']} ${postData['model']}',
      'modelYear': '${postData['modelYear']}'
    };
    await _db.collection(DBCollections.orders).add(orderDetail);
    await _db
        .collection(DBCollections.users)
        .doc(userId)
        .collection(DBCollections.order)
        .add(orderDetail);
    await _db.collection(DBCollections.posts).doc(postData.id).update({
      'sold': true,
    });
    await homeController.getData();
    return trackingID;
  }

  /// update shipping address in firebase
  Future<void> updateShippingAddress(Map<String, dynamic> updatedAddress,
      Map<String, dynamic> oldAddress) async {
    purchaseLoading.value=true;
    update();
    var userId = await LocalDB().getUserId();
    await _db.collection(DBCollections.users).doc(userId).update({
      'shippingAddresses': FieldValue.arrayRemove([oldAddress])
    });
    await _db.collection(DBCollections.users).doc(userId).update({
      'shippingAddresses': FieldValue.arrayUnion([updatedAddress])
    });
    await getShippingAddress();
    purchaseLoading.value=false;
    update();
  }

  /// update address in page
  Future<void> updateAddress(Map<String, dynamic> oldAddress) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> updatedAddress = {
        'address': addressController.value.text.trim(),
        'city': cityController.value.text.trim(),
        'country': countryController.value.text.trim(),
        'state': stateController.value.text.trim(),
        'postcode': postalCodeController.value.text.trim(),
      };
      updateShippingAddress(updatedAddress, oldAddress).then((value) {
        isLoading.value = false;
        Get.back();
      });
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error updating address: $e');
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    cityController.dispose();
    countryController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }
}
