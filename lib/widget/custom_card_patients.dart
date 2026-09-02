import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/edit_data_patient_page.dart';
import 'package:clinic_app/screens/sessions_page.dart';
import 'package:clinic_app/widget/Send_Message_Dialog.dart';
import 'package:flutter/material.dart';

class CustomCardPatients extends StatelessWidget {
  const CustomCardPatients({
    super.key,
    required this.patientName,
    this.onTap,
    required this.numberphone,
    required this.age,
    required this.docId,
  });

  final String patientName;
  final String numberphone;
  final int age;
  final String docId;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: Card(
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    // 1. صورة المريض (بدون Expanded لتثبيت الحجم الدائري)
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: gold.withValues(alpha: 0.18),
                      child: Icon(
                        Icons.person,
                        color: darkGold,
                        size: 35,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // 2. بيانات المريض
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            patientName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 13,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "967$numberphone+",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.cake_outlined,
                                size: 13,
                                color: kFontColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "$age سنة",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // 3. أزرار الجلسات وإرسال الإشعار
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              SessionsPage.id,
                              arguments: docId,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: gold.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "قائمة الجلسات",
                              style: TextStyle(
                                color: kFontColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SendMessageDialog(
                                  patientName: patientName,
                                  phone: '+967$numberphone',
                                  appointmentTime: '5:00 مساءً',
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.chat,
                            color: Color(0xFFD6A857),
                            size: 24,
                          ),
                        ),
                      ],
                    ),

                    // 4. سهم الانتقال للتعديل
                    IconButton(
                      padding: const EdgeInsets.only(right: 4),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          EditDataPatientPage.id,
                          arguments: docId,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFFD6A857),
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}