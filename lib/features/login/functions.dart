import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

Future<User?> login(String email, String password) async {
  final credential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
  return credential.user;
}

Future<MyAppUser?> register(String email, String password, String name) async {
  final credential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

  final user = credential.user;
  user?.updateDisplayName(name);

  final myAppUser = MyAppUser(name);

  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(myAppUser.toJson());
  }
  return myAppUser;
}
