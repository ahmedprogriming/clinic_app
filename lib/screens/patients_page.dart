import 'package:clinic_app/Constant.dart';
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
      
      body:SafeArea(child:  ListPatients(),)
     
    );
  }
}