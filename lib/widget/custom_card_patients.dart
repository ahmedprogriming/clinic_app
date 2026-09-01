import 'package:clinic_app/Constant.dart';
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
    required this.age, required this.docId,
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: 140,
              width: 1000,

              child: Card(
                color: Colors.white,
                elevation: 2,

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        // صورة المريض
                          CircleAvatar(
                                  radius: 40,
                                  backgroundColor: gold.withValues(alpha: 0.18),
                                  child: Icon(
                                    Icons.person,
                                    color: darkGold,
                                    size: 40,
                                  ),
                                ),

                        const SizedBox(width: 16),
                        //date patient
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                               Text(
                                patientName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 14),

                              Row(
                                children:  [
                                const  Icon(
                                    Icons.phone,
                                    size: 12,
                                    color: Colors.green,
                                  ),
                                 const SizedBox(width: 5),
                                  Text(
                                    "967$numberphone+",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),

                              Row(
                                children:  [
                                const  Icon(
                                    Icons.cake_outlined,
                                    size: 12,
                                    color: kFontColor,
                                  ),
                                const  SizedBox(width: 5),
                                  Text(
                                    "$age سنة",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      SessionsPage.id,
                                      arguments: docId
                                    );
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    height: 20,
                                    child: const Text(
                                      " قائمة الجلسات",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: kFontColor,

                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            SizedBox(
                              width: 100,
                              child: const Text(
                                "ارسال اشعار",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Expanded(
                              child: IconButton(
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
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  EditDataPatientPage.id,
                                  arguments: docId
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFFD6A857),
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
