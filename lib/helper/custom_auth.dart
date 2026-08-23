
   import 'package:firebase_auth/firebase_auth.dart';

  

Future<void> LoginAuth(String email,password) async {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }