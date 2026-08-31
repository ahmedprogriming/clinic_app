import 'package:clinic_app/constant.dart';

import 'package:clinic_app/widget/edit_data_patient.dart';
import 'package:flutter/material.dart';

class EditDataPatientPage extends StatelessWidget {
  const EditDataPatientPage({super.key});
  static String id = 'EditDataPatientPage';

  @override
  Widget build(BuildContext context) {
    final String docId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: kPrimaryColor,

      
      body: SafeArea(child: EditPatient(docId: docId),)
      
    );
  }
}
