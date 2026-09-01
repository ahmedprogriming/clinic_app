import 'package:clinic_app/Constant.dart';
import 'package:clinic_app/screens/cubits/add_patient_cubit/cubit/add_patient_cubit.dart';
import 'package:clinic_app/widget/add_new_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewPatientPage extends StatelessWidget {
  const AddNewPatientPage({super.key});

  static String id = 'AddNewpatientPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPatientCubit(),
      child: Scaffold(
        backgroundColor: kPrimaryColor,

        body: SafeArea(
        
          child: AddNewPatient(),
        ),
      ),
    );
  }
}
