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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Initialize locale formatting for Arabic (or null to initialize all)
  await initializeDateFormatting('ar', null);

  // إبقاء شاشة الـ Splash نشطة
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('is_first_time') ?? true;
  final bool rememberMe = prefs.getBool('remember_me') ?? false;
  
  User? currentUser = FirebaseAuth.instance.currentUser;

// إذا لم يفعل المستخدم خيار "تذكرني"، يتم تسجيل الخروج تلقائياً
  if(currentUser != null && !rememberMe) {
    await FirebaseAuth.instance.signOut();
    currentUser = null;
  }

 String startRouteId;

  if (currentUser != null) {
    // المستخدم مفعل "تذكرني" وجلسته نشطة
    startRouteId = DashboardPage.id;
  } else if (isFirstTime) {
    startRouteId = RagesterPage.id;
  } else {
    // مستخدم لم يفعل "تذكرني" أو مسجل خروج
    startRouteId = LoginPage.id;
  }

  // إزالة شاشة الـ Splash عند انتهاء التحميل والانتقال للتطبيق
  FlutterNativeSplash.remove();

  runApp( ClinicApp(startRoute: startRouteId ));
}

class ClinicApp extends StatelessWidget {
  const ClinicApp({super.key, this.startRoute = LoginPage.id});
 final String startRoute;
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
        initialRoute: startRoute,
        title: 'عيادتي',
        theme: ThemeData(primaryColor: Color(0xffFDF9F1)),
      ),
    );
  }
}
