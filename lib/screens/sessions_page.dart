import 'package:clinic_app/constant.dart';
import 'package:clinic_app/widget/list_session.dart';
import 'package:flutter/material.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  static String id = 'SessionPage';
  @override
  Widget build(BuildContext context) {
    final String docId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: kPrimaryColor,

      body: SafeArea(child: ListSession(docId: docId)),
    );
  }
}
