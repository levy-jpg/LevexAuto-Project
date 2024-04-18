import 'dart:async';
import 'package:get/get.dart';

class OverlayController extends GetxController {
  var progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    simulateLoading();
  }

  void simulateLoading() async {
    int totalDuration = 4000; // Total duration of 4 seconds
    int updates = 100; // We will update 100 times
    int delay = totalDuration ~/ updates; // Delay between updates

    for (int i = 0; i <= updates; i++) {
      await Future.delayed(Duration(milliseconds: delay));
      progress.value = i / updates;
    }
  }
}
