import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:levexauto/utils/collections.dart';

import '../utils/utils.dart';

class UserServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// save user into cloud fire store database
  Future<void> userSave({
    required String userId,
    required String userName,
    required String email,
  }) async {

    Map<String, dynamic> user = {
      'username': userName,
      'email': email,
      'favList':[],
    };

    try {
      _db.collection(DBCollections.users).doc(userId).set(user).then((value) {
        debugPrint("User info successfully uploaded for docId: $userId");
      });
    } catch (e) {
      debugPrint("Failed to upload user info for docId: $userId, Error: $e");
      CustomToast().showToast(
        msgText: e.toString(),
      );
    }
  }
}
