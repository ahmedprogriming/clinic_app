import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/cubits/add_patient_cubit/cubit/add_patient_cubit.dart';
import 'package:clinic_app/widget/add_new_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewPatientPage extends StatelessWidget {
  const AddNewPatientPage({super.key});

  static String id = 'AddNewpatientPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'اضافة مريض جديد',
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
      body: BlocProvider(
        create: (context) => AddPatientCubit(),
        child:  AddNewPatient(),
      ),
    );
  }
}
