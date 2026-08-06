import 'package:clinic_app/constant.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_card_patients.dart';
import 'package:flutter/material.dart';

class ListPatients extends StatelessWidget {
  const ListPatients({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 4),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(      
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'The field is required';
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.black,
                        
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      hintText: 'ابحث عن اسم المريض',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xff999896),
                     
                      ),
                        
                      hintStyle: const TextStyle(
                        color: Color(0xff999896),
                        fontSize: 12,
                       
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xffEBE7E4)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xffEBE7E4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xff999896)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 100,
                height: 50,
                child: CustomButton(
                  buttonColor: Color(0xffFDF9F1),
                  borderColor: Color(0xffEBE7E4),
                  namebutton: 'بحث',
                 icon: Icon(Icons.tune, size: 24, color: Color(0xff8D734B)),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
    
        Expanded(
          child: ListView.builder(
            itemCount: 10, // Replace with the actual number of patients
            itemBuilder: (context, index) {
              return CustomCardPatients(
                patientName:
                    'Patient ${index + 1}', // Replace with actual patient name
                onTap: () {
                  // Handle card tap, e.g., navigate to patient details page
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
