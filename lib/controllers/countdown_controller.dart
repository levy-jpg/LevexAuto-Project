import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/local_db.dart';
import '../utils/custom_toast.dart';

class CountdownController extends GetxController {
  Rx<Duration> timeLeft =
      const Duration(days: 1, hours: 4, minutes: 23, seconds: 56).obs;
  Timer? _timer;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > Duration.zero) {
        timeLeft.value = timeLeft.value - const Duration(seconds: 1);
      } else {
        timer.cancel();
      }
    });
  }

  TextEditingController bidController = TextEditingController();
  GlobalKey<FormState> bidKey = GlobalKey<FormState>();

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  /// biding function here
  biding(docId, amount) async {
    if (bidKey.currentState!.validate()) {
      try {
        var userId = await LocalDB().getUserId();
        await _db.collection('posts').doc(docId).update({
          'price': amount,
        });
        await _db.collection('posts').doc(docId).collection('bids').add({
          'bidPrice': amount,
          'userId': userId,
          'postId': docId,
          'date': DateTime.now(),
        });
        CustomToast().showToast(
          msgText: "Bid  successfully",
        );
      } catch (e) {
        CustomToast().showToast(
          msgText: e.toString(),
        );
      }
    } else {}
  }
}
