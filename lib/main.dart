import 'package:clinic_app/screens/add_new_patient_page.dart';
import 'package:clinic_app/screens/dashboard_page.dart';
import 'package:clinic_app/screens/edit_data_patient_page.dart';
import 'package:clinic_app/screens/login_page.dart';
import 'package:clinic_app/screens/patients_page.dart';
import 'package:clinic_app/screens/ragester_page.dart';
import 'package:clinic_app/screens/sessions_page.dart';
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
      RagesterPage.id: (context) => const RagesterPage(),
      DashboardPage.id: (context) => const DashboardPage(),
      PatientsPage.id:(context) => const PatientsPage(),
      AddNewPatientPage.id:(context)=> const AddNewPatientPage(),
      EditDataPatientPage.id:(context)=> const EditDataPatientPage(),
      SessionsPage.id:(context) => const SessionsPage()
       
      },
      initialRoute: DashboardPage.id,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor:Color(0xffFDF9F1)
      ),
    
    );
  }
}