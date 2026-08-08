import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/add_new_patient_page.dart';
import 'package:clinic_app/widget/lisr_patients.dart';
import 'package:flutter/material.dart';

class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});
  static String id='PatientsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the button press action here
          Navigator.pushNamed(context, AddNewPatientPage.id);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(0xffD8A33D),
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title:Text('Patints'
        ,style: TextStyle(color:Color(0xff8F6337)),) ,
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
      body:ListPatients(),
    );
  }
}