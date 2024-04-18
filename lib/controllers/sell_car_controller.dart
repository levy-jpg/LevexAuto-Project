import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:levexauto/utils/enums.dart';
import 'package:location/location.dart';
import '../services/local_db.dart';
import '../utils/collections.dart';
import '../utils/custom_toast.dart';
import 'package:geocoding/geocoding.dart' as geoCode;

class SellCarController extends GetxController {
  GlobalKey<FormState> carPostKey = GlobalKey<FormState>();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController vehicleHistoryController = TextEditingController();
  TextEditingController specificationsController = TextEditingController();
  TextEditingController otherDescController = TextEditingController();
  TextEditingController addPriceController = TextEditingController();
  Rx<CarCondition> condition = CarCondition.used.obs;
  Rx<SellType> sellType = SellType.fixed.obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var postLoading = false.obs;
  LocationData? currentLocation;
  var country;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    vehicleImages.clear();
    getLocation();
    update();
  }

  /// List of items for the dropdown
  var items = ["2020", "2021", "2022", "2023", "2024", "2025"].obs;
  var countries = ["Kenya",'United Kingdom'].obs;
  /// The selected item
  var selectedModelYear = "2022".obs;
  var selectedCountry = "Kenya".obs;
  final vehicleImages = [].obs;
  final geo = GeoFlutterFire();

  void conditionSelectFun(CarCondition carCondition) {
    condition.value = carCondition;
    update();
  }

  void sellTypeFun(SellType type) {
    sellType.value = type;
    selectedModelYear.value = "";
  }

  /// function for section of gallery image
  Future getGalleryImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      vehicleImages.add({
        'file': File(pickedFile.path),
        'path': pickedFile.path,
        'url': '',
      });
      update();
      Get.back();
    }
  }

  /// upload image to firebase here
  Future uploadImages() async {
    List<String> uploadedImageUrls = [];

    for (int i = 0; i < vehicleImages.length; i++) {
      if (vehicleImages[i]["path"] != '') {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageReference =
            FirebaseStorage.instance.ref().child('images/$fileName.png');
        debugPrint("here is the ${File("${vehicleImages[i]["path"]}")}");
        UploadTask uploadTask =
            storageReference.putFile(File("${vehicleImages[i]["path"]}"));
        final snapshot3 = await uploadTask.whenComplete(() => null);
        var imageUrl3 = await snapshot3.ref.getDownloadURL();
        uploadedImageUrls.add(imageUrl3);
      } else {
        uploadedImageUrls.add(vehicleImages[i]["url"]);
      }
    }

    return uploadedImageUrls;
  }

  /// getting user current location
  Future<void> getLocation() async {
    Location location = Location();
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      LocationData locationData = await location.getLocation();
      currentLocation = locationData;
      debugPrint("here is the data ${currentLocation!}");
      await getAddressFromCoordinates(
          locationData.latitude!,
        /// uk lat
          // 51.5074,
        /// kenya lat
        //   -4.043477,
          locationData.longitude!
        /// uk long
          // 0.1278
        /// kenya long
        //   39.668206
      );
      update();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  /// getting address form coordinates
  Future<void> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<geoCode.Placemark> placeMarks =
          await geoCode.placemarkFromCoordinates(latitude, longitude);
      if (placeMarks != null && placeMarks.isNotEmpty) {
        geoCode.Placemark placeMark = placeMarks.first;
        // print('Address: ${placeMark.street}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.country}');
        country = placeMark.country;
        locationController.text =
            "${placeMark.street}, ${placeMark.locality}, ${placeMark.administrativeArea}, ${placeMark.country}";
        update();
      }
    } catch (e) {
      debugPrint('Error getting address from coordinates: $e');
    }
  }

  /// creating searching index function
  List<String> generateSubstrings(String inputString) {
    List<String> substrings = [];
    for (int i = 1; i <= inputString.length; i++) {
      substrings.add(inputString.substring(0, i));
    }
    return substrings;
  }
  /// here is the functions for uploading post
  Future<void> postCar() async {
    if (carPostKey.currentState!.validate()) {
      postLoading.value = true;
      update();
      var imagesUrls = [];
      var searchIndex= generateSubstrings('${manufacturerController.text.trim().toLowerCase()} ${modelController.text.trim().toLowerCase()} ${selectedModelYear.toString()}');
      var modelIndex=generateSubstrings(modelController.text.trim().toLowerCase());
      searchIndex.addAll(modelIndex);
      var yearIndex=generateSubstrings(selectedModelYear.toString());
      searchIndex.addAll(yearIndex);
      /// Uploading Vehicles images
      if (vehicleImages.isNotEmpty) {
        imagesUrls = await uploadImages();
      }
      // String searchIndex = _createSearchIndex(modelController.text.trim(), manufacturerController.text.trim(), selectedModelYear.toString());
      /// getting user id here
      var userId = await LocalDB().getUserId();
      Map<String, dynamic> postData = {
        'userId': userId,
        'manufacture': manufacturerController.text.trim(),
        'model': modelController.text.trim(),
        'modelYear': selectedModelYear.value.trim(),
        'address': locationController.text.trim(),
        'location': geo
            .point(
                latitude: currentLocation!.latitude!,
                longitude: currentLocation!.longitude!)
            .data,
        'country':selectedCountry.value,
        'condition': condition.value == CarCondition.used ? "Used" : "New",
        'vehicleHistory': vehicleHistoryController.text.trim(),
        'specifications': specificationsController.text.trim(),
        'description': otherDescController.text.trim(),
        'images': imagesUrls.isNotEmpty ? imagesUrls : [],
        'sellType': sellType.value == SellType.fixed ? "Fixed" : "Bid",
        'searchIndex': searchIndex,
        // 'country': country,
        'sold': false,
        'price': sellType.value == SellType.fixed
            ? addPriceController.text.trim()
            : "0"
      };
      try {
        await _db.collection(DBCollections.posts).add(postData).then((value) {
          resetData();
          CustomToast().showToast(
            msgText: "Data Submitted successfully",
          );
        });
        postLoading.value = false;
      } catch (e) {
        postLoading.value = false;
        CustomToast().showToast(
          msgText: e.toString(),
        );
      }
    } else {
      postLoading.value = false;
    }
  }

  /// reset all value
  resetData() {
    manufacturerController.clear();
    modelController.clear();
    locationController.clear();
    vehicleHistoryController.clear();
    specificationsController.clear();
    otherDescController.clear();
    addPriceController.clear();
    vehicleImages.clear();
    selectedModelYear.value = '';
    update();
  }
 }

