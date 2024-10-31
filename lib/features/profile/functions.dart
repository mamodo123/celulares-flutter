import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
}

Future<String> changeName(String name) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Future.error('Current user is not setted');
  } else {
    user.updateDisplayName(name);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'name': name});
  }
  return user.uid;
}
