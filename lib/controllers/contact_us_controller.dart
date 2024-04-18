import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:levexauto/constants/app_colors.dart';
import 'package:levexauto/utils/custom_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  final Uri contactUsUri = Uri(
    scheme: 'mailto',
    path: 'intertrick99@gmail.com',
    query: Uri.encodeFull('subject=LevexAuto App'),
  );

  /// send mail
  void sendMail() async {
    if (key.currentState!.validate()) {
      isLoading.value = true;
      launchContactUsMail().then((value) {
        usernameController.clear();
        emailController.clear();
        descController.clear();
        CustomToast().showToast(
          msgText: 'Email send successfully!',
          bgColor: AppColors.greenLightColor,
        );
        isLoading.value = false;
      });
    } else {
      isLoading.value = false;
    }
  }

  ///
  Future<void> launchContactUsMail() async {
    if (await canLaunch(contactUsUri.toString())) {
      await launch(contactUsUri.toString());
    } else {
      debugPrint('Could not launch ${contactUsUri.toString()}');
    }
  }
}
