import 'package:clinic_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ClinicApp());
}

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
      LoginPage.id: (context) => const LoginPage(),
       
      },
      initialRoute: LoginPage.id,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor:Color(0xffFDF9F1)
      ),
    
    );
  }
}