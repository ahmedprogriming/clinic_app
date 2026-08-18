import 'package:clinic_app/constant.dart';
import 'package:clinic_app/widget/edit_session.dart';
import 'package:flutter/material.dart';

class EditSessionPage extends StatelessWidget {
  const EditSessionPage({super.key});
static String id='EditSessionPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,

      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'تعديل جلسة',
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
      body: EditSession(),
    );
  }
}