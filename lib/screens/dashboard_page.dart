import 'package:clinic_app/Constant.dart';
import 'package:clinic_app/widget/main_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  static String id = 'DashboardPage';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       backgroundColor: kPrimaryColor,
       body: MainPage()
    );
  }
}