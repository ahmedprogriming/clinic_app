import 'package:clinic_app/screens/add_new_patient_page.dart';
import 'package:clinic_app/screens/add_new_session_Page.dart';

import 'package:clinic_app/screens/cubits/edit_patient_cubit/cubit/edit_patient_cubit.dart';
import 'package:clinic_app/screens/cubits/login_cubit/login_cubit.dart';
import 'package:clinic_app/screens/cubits/patients_cubit/patients_cubit.dart';
import 'package:clinic_app/screens/cubits/session_cubit/cubit/sessionlist_cubit.dart';
import 'package:clinic_app/screens/dashboard_page.dart';
import 'package:clinic_app/screens/details_session_page.dart';
import 'package:clinic_app/screens/edit_data_patient_page.dart';
import 'package:clinic_app/screens/edit_session_page.dart';
import 'package:clinic_app/screens/login_page.dart';
import 'package:clinic_app/screens/patients_page.dart';
import 'package:clinic_app/screens/ragester_page.dart';
import 'package:clinic_app/screens/sessions_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize locale formatting for Arabic (or null to initialize all)
  await initializeDateFormatting('ar', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ClinicApp());
}

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => PatientsCubit()),
        BlocProvider(create: (context) => EditPatientCubit()),
        BlocProvider(create: (context) => SessionlistCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RagesterPage.id: (context) => const RagesterPage(),
          DashboardPage.id: (context) => const DashboardPage(),
          PatientsPage.id: (context) => const PatientsPage(),
          AddNewPatientPage.id: (context) => const AddNewPatientPage(),
          EditDataPatientPage.id: (context) => const EditDataPatientPage(),
          SessionsPage.id: (context) => const SessionsPage(),
          DetailsSessionPage.id: (context) => const DetailsSessionPage(),
          AddNewSessionPage.id: (context) => const AddNewSessionPage(),
          EditSessionPage.id: (context) => const EditSessionPage(),
        },
        initialRoute: RagesterPage.id,
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Color(0xffFDF9F1)),
      ),
    );
  }
}
