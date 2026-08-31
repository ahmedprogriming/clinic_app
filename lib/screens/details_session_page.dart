import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/cubits/editSession_cubit/edit_session_cubit.dart';
import 'package:clinic_app/widget/detail_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsSessionPage extends StatelessWidget {
  const DetailsSessionPage({super.key});
  static String id = 'DetailSessionPage';

  @override
  Widget build(BuildContext context) {
    final docId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => EditSessionCubit()..getSessiondata(docId),
      child: Scaffold(
        backgroundColor: kPrimaryColor,

        
        body: SafeArea(child:  DetailSession(sessionId: docId),)
       
      ),
    );
  }
}
