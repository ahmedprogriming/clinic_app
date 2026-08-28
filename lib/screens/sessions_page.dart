import 'package:clinic_app/constant.dart';
import 'package:clinic_app/widget/list_session.dart';
import 'package:flutter/material.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

static String id='SessionPage';
  @override
  Widget build(BuildContext context) {
    final String docId = ModalRoute.of(context)!.settings.arguments as String;
    return  Scaffold(
       backgroundColor: kPrimaryColor,

        appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title:Text('قائمة جلسات المريض'
        ,style: TextStyle(color:Color(0xff8F6337),
        fontWeight: FontWeight.bold),) ,
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
      body:ListSession(docId: docId,)
    );
  }
}