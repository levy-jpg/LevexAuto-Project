import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:levexauto/utils/utils.dart';

import '../services/local_db.dart';
import '../utils/custom_toast.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  var loading = false.obs;
  var trackingOrders = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTrackingOrder();
    update();
  }

  updateData() async {
    loading.value = true;
    update();
    await getTrackingOrder();
    loading.value = false;
    update();
  }

  getTrackingOrder() async {
    try {
      String? userId = await LocalDB().getUserId();
      var trackingOrder = await _db
          .collection(DBCollections.users)
          .doc(userId)
          .collection(DBCollections.order)
          .get();
      trackingOrders.clear();
      trackingOrders.addAll(trackingOrder.docs);
      update();
    } catch (e) {
      loading.value = false;
      CustomToast().showToast(
        msgText: e.toString(),
      );
    }
  }
}
