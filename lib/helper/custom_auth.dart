
   import 'package:clinic_app/Constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

  

Future<void> loginAuth(String email,String password) async {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> regesterUser(String email,String password,String username) async
  {
    final credential = await FirebaseAuth.instance
    .createUserWithEmailAndPassword(
  email: email,
  password: password,
);

final uid = credential.user!.uid;

await FirebaseFirestore.instance
    .collection(kusersCollection)
    .doc(uid)
    .set({
  'email': email,
  'username': username,
});
  }