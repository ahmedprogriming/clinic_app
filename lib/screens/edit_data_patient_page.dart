import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/cubits/edit_patient_cubit/cubit/edit_patient_cubit.dart';
import 'package:clinic_app/widget/edit_data_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDataPatientPage extends StatelessWidget {
  const EditDataPatientPage({super.key});
  static String id = 'EditDataPatientPage';

  @override
  Widget build(BuildContext context) {
    final String docId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => EditPatientCubit(),
      child: Scaffold(
        backgroundColor: kPrimaryColor,

        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'تعديل بيانات المريض',
            style: TextStyle(
              color: Color(0xff8F6337),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFD6A857).withOpacity(0.15),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFFD6A857),
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        body: EditPatient(docId: docId),
      ),
    );
  }
}
