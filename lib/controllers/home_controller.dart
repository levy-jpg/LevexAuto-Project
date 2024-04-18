import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';
import 'package:levexauto/controllers/profile_controller.dart';
import 'package:levexauto/controllers/sell_car_controller.dart';
import 'package:levexauto/utils/collections.dart';

import '../services/local_db.dart';

class HomeController extends GetxController {
  TextEditingController searchCarController = TextEditingController();
  SellCarController sellCarController = Get.put(SellCarController());
  ProfileController controller = Get.put(ProfileController());
  final geo = GeoFlutterFire();
  var loadingData = false.obs;
  var kenyaData = [].obs;
  var uKCarPostData = [].obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  getData() async {
    await controller.getTrackingOrder();
    await getKenyaData();
    await getUkData();
    sellCarController.getLocation();
    // await getFavouriteList();
    loadingData.value = false;
    update();
  }

  /// getting data near my location
  Stream<List<DocumentSnapshot<Object?>>> recommendedPost() {
    update();
    GeoFirePoint center = geo.point(
        latitude: sellCarController.currentLocation!.latitude!,
        longitude: sellCarController.currentLocation!.longitude!);

    var collection = FirebaseFirestore.instance
        .collection(DBCollections.posts)
        .where('sold', isEqualTo: false).where("country", isEqualTo: '${sellCarController.country}');
    var result = geo.collection(collectionRef: collection).within(
          center: center,
          radius: 30.0,
          field: 'location',
          strictMode: true,
        );
    return result.asBroadcastStream();
  }

  /// get kenya data
  getKenyaData() async {
    var result = await FirebaseFirestore.instance
        .collection(DBCollections.posts)
        .where("country", isEqualTo: 'Kenya')
        .where('sold', isEqualTo: false)
        .get();
    kenyaData.clear();
    kenyaData.addAll(result.docs);
    update();
  }

  getUkData() async {
    update();
    var result = await FirebaseFirestore.instance
        .collection(DBCollections.posts)
        .where("country", isEqualTo: 'United Kingdom')
        .where('sold', isEqualTo: false)
        .get();
    uKCarPostData.clear();
    uKCarPostData.addAll(result.docs);
    update();
  }

  var searchingResult=[].obs;
  var searchLoading=false.obs;
  /// searching functionality
  searching(query) async {
    searchLoading.value=true;
    update();
    final CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');
    var result = await postCollection
        .where('searchIndex', arrayContains: query.toString().toLowerCase())
        .get();
    searchingResult.clear();
    update();
    searchingResult.addAll(result.docs);
    searchLoading.value=false;
    update();
  }
  /// add to fav functionality

  addFavourite(id) async {
    var userId = await LocalDB().getUserId();
    await _db.collection('users').doc(userId).update({
      'favList': FieldValue.arrayUnion([id]),
    });
    getData();
  }

  /// remove fav list
  removeFavourite(id) async {
    var userId = await LocalDB().getUserId();
    await _db.collection('users').doc(userId).update({
      'favList': FieldValue.arrayRemove([id]),
    });
    await getFavouriteList();
  }
  
  var favList=[].obs;
  var favListData=[].obs;
  var favLoading=false.obs;
  /// get fav list
  getFavouriteList() async {

    var userId = await LocalDB().getUserId();
    var result =await _db.collection('users').doc(userId).get();
    favList.clear();
    favListData.clear();
    favList.addAll(result['favList']);
    update();
    for(int i=0; i<favList.length; i++){
      var result =await fetchDocument(favList[i]);
      favListData.add(result);
    }
    update();
  }

  Future<DocumentSnapshot> fetchDocument(String documentId) {
    return FirebaseFirestore.instance.collection('posts').doc(documentId).get();
  }
}
