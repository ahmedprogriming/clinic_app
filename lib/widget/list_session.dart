import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/add_new_session_Page.dart';
import 'package:clinic_app/widget/add_new_session.dart';
import 'package:clinic_app/widget/custom_elevated_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:clinic_app/widget/custom_records_session.dart';
import 'package:clinic_app/widget/custom_small_contaner.dart';
import 'package:flutter/material.dart';

class ListSession extends StatelessWidget {
  const ListSession({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              const SizedBox(height: 20),
              // ========================= // معلومات المريض // =========================
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: gold.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: gold.withOpacity(0.18),
                          child: Icon(Icons.person, color: darkGold, size: 40),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ملف المريض',
                                style: TextStyle(fontSize: 12, color: fontc),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'سارة محمد العتيبي',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '+967 777 123 456',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: fontc,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(Icons.phone, size: 15, color: fontc),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // الشريط الموجود تحت رقم الهاتف
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: cream,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الجلسات السابقة',
                            style: TextStyle(fontSize: 13, color: fontc),
                          ),
                          Text(
                            '12 جلسة',
                            style: TextStyle(
                              fontSize: 13,
                              color: darkGold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // ========================= // آخر جلسة والجلسة القادمة // =========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Custom_small_contaner(
                        textTop: 'آخر جلسة',
                        textbottom: '8 أغسطس',
                        icon: const Icon(Icons.edit_calendar_sharp),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Custom_small_contaner(
                        textTop: 'الجلسة القادمة',
                        textbottom: '8 أغسطس',
                        icon: const Icon(Icons.hourglass_empty),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // ========================= // البحث // =========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomTextFiled(
                  hint: 'البحث في الجلسات...',
                  hintColor: Colors.grey,
                  fontsizehint: 16,
                  icon: Icons.search,
                  fillcolor: Colors.white,
                  bordercolor: const Color(0xffE8DECC),
                  textdecoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 30),
              // ========================= // عنوان سجل الجلسات // =========================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'سجل الجلسات',
                  style: TextStyle(
                    fontSize: 20,
                    color: darkGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ========================= // الجلسات // =========================
              ...List.generate(10, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: RecordsSessionPatient(
                    textTop: 'الجلسة# ${index + 1}',
                    textbottom: '8 أغسطس - 2026 - 5:00 مساء',
                  ),
                );
              }),
            ],
          ),

          Positioned(
            bottom: 40,
            right: 16,
            child: SizedBox(
              width: 160,
              height: 55,
              child: CustomElevatedButton(
                icon: Icons.add,
                backgroundcolor: darkGold,
                text: 'إضافة جلسة',
                onPressed: () {
                  Navigator.pushNamed(context,AddNewSessionPage.id);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
