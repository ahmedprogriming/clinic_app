import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/cubits/addSession_cubit/add_session_cubit.dart';
import 'package:clinic_app/widget/add_new_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewSessionPage extends StatelessWidget {
  const AddNewSessionPage({super.key});

  static String id = 'AddNewSession';

  @override
  Widget build(BuildContext context) {
    final String docId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => AddSessionCubit(),
      child: Scaffold(
        backgroundColor: kPrimaryColor,

       
        body: SafeArea(child: AddNewSession(patientID: docId,),)
        
      ),
    );
  }
}
