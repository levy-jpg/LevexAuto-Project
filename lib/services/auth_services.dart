import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:levexauto/views/signin/signin_page.dart';

import '../constants/constants.dart';
import '../utils/utils.dart';
import '../views/main_menu/main_menu_page.dart';
import 'local_db.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// login user with email and password
  Future<void> userLoginFun({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        CustomToast().showToast(
          msgText: 'Successfully LoggedIn',
          bgColor: AppColors.greenDarkColor,
        );
        var userId = value.user!.uid;
        await LocalDB().saveUserId(userId);
        Get.offAll(const MainMenuPage());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == "wrong-password" ||
          e.code == "invalid-credential") {
        CustomToast().showToast(
          msgText: 'Please verify your username or password and try again.',
          bgColor: AppColors.primaryColor,
        );
      }
    } catch (e) {
      if (e == 'user-not-found' ||
          e == 'wrong-password' ||
          e == 'invalid-credential') {
        CustomToast().showToast(
          msgText: 'Please verify your username or password and try again.',
          bgColor: AppColors.primaryColor,
        );
      }
    }
  }

  /// register user with email and password
  Future<String> registerWithEmailAndPass({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('User ID: ${user.user!.uid}');
      return user.user!.uid ?? '';
    } on FirebaseAuthException catch (value) {
      if (value.code == 'email-already-in-use') {
        CustomToast().showToast(
          msgText:
              "Email already registered, log in if you already have an account or try to recover your password.",
          bgColor: AppColors.primaryColor,
        );
      }
      else if (value.code == 'ERROR_WEAK_PASSWORD') {
        CustomToast().showToast(
          msgText: "Please enter a strong password.",
          bgColor: AppColors.primaryColor,
        );
      } else if (value.code == 'ERROR_INVALID_EMAIL') {
        CustomToast().showToast(
          msgText: "Please enter a valid email.",
          bgColor: AppColors.primaryColor,
        );
      } else {
        CustomToast().showToast(
          msgText: value.message.toString(),
          bgColor: AppColors.primaryColor,
        );
      }

      return '';
    } catch (e) {
      CustomToast().showToast(
        msgText: e.toString(),
        bgColor: AppColors.primaryColor,
      );
      return '';
    }
  }

  /// user logout function
  Future<void> userLogout() async {
    try {
      if (firebaseAuth.currentUser != null) {
        firebaseAuth.signOut().then((value) {
          CustomToast().showToast(
            msgText: 'Sign out Successfully',
            bgColor: AppColors.greenDarkColor,
          );
          Get.offAll(const SignInPage());
        });
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Error: $e');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
