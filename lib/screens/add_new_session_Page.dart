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

        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'اضافة جلسة',
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
        body: AddNewSession(patientID: docId,),
      ),
    );
  }
}
