import 'package:get/get.dart';

class MainMenuController extends GetxController {
  Rx<int> currentIndex = 0.obs;

  void setTab(int index) {
    currentIndex.value = index;
    update();
  }
}
