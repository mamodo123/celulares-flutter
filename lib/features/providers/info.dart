import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:phones/features/login/models/user.dart';

class Info extends ChangeNotifier {
  MyAppUser? _user;

  MyAppUser? get user => _user;

  set user(MyAppUser? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> reloadUser(String uid) async {
    final docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = docSnapshot.data();
    if (data != null) {
      final myAppUser = MyAppUser.fromJson(data);

      user = myAppUser;
    }
  }
}
