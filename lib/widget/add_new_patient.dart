import 'package:clinic_app/constant.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:clinic_app/widget/custom_text.dart';
import 'package:flutter/material.dart';

class AddNewPatient extends StatefulWidget {
  const AddNewPatient({super.key});

  @override
  State<AddNewPatient> createState() => _AddNewPatientState();
}

class _AddNewPatientState extends State<AddNewPatient> {
  final items = ['ذكر', 'أنثى'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: 350,
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 0.1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    const CustomText(text: 'الأسم الكامل*'),
                    const Directionality(
                      textDirection: TextDirection.ltr,
                      child: CustomTextFiled(
                        height: 55,
                        width: 310,
                        hint: 'أدخل الأسم الكامل',
                        hintColor: Colors.grey,
                        textdecoration: TextDecoration.none,
                        bordercolor: Color(0xffEBE7E4),
                        icon: Icons.person,
                      ),
                    ),
                    const CustomText(text: 'رقم الهاتف*'),
                    const Directionality(
                      textDirection: TextDirection.ltr,
                      child: CustomTextFiled(
                        height: 55,
                        width: 310,
                        hint: 'أدخل رقم الهاتف',
                        hintColor: Colors.grey,
                        textdecoration: TextDecoration.none,
                        bordercolor: Color(0xffEBE7E4),
                        icon: Icons.phone,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomText(text: 'الجنس*'),
                        CustomText(text: 'العمر*'),
                      ],
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 55,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xffEBE7E4)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedValue,
                                hint: const Text(
                                  ' اختر الجنس',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                isExpanded: true,
                                iconSize: 25,
                                icon: const Icon(Icons.arrow_drop_down, color: Color(0xffC1AD94)),
                                items: items.map(buildMenuItem).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          const CustomTextFiled(
                            hint: 'أدخل العمر',
                            height: 55,
                            width: 150,
                            hintColor: Colors.grey,
                            textdecoration: TextDecoration.none,
                            bordercolor: Color(0xffEBE7E4),
                            icon: Icons.calendar_month,
                          ),
                        ],
                      ),
                    ),
                    const CustomText(text: 'العنوان*'),
                    const Directionality(
                      textDirection: TextDirection.ltr,
                      child: CustomTextFiled(
                        hint: 'أدخل العنوان',
                        height: 55,
                        width: 350,
                        hintColor: Colors.grey,
                        textdecoration: TextDecoration.none,
                        bordercolor: Color(0xffEBE7E4),
                        icon: Icons.add_to_home_screen_sharp,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 150),
              Container(
                 padding: const EdgeInsets.all(16),
                 height: 80,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 0.1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffB28238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text(
                        'إضافة',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                        color: Colors.white),
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          
                         
                        ),
                        
                        
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      ),
                      child: const Text(
                        'الغاء',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                        color: kFontColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
}