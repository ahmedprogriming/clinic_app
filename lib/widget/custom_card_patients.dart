import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/edit_data_patient_page.dart';
import 'package:clinic_app/screens/sessions_page.dart';
import 'package:clinic_app/widget/Send_Message_Dialog.dart';
import 'package:flutter/material.dart';

class CustomCardPatients extends StatelessWidget {
  const CustomCardPatients({super.key, required this.patientName, this.onTap});
  final String patientName;

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
            Container(
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
                        const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            "lib/assets/images/icons8-avatar-50.png",
                          ),
                        ),
                    
                        const SizedBox(width: 16),
                        //date patient
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                    
                            children: [
                              const Text(
                                "احمد خالد عوض جيود",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 14),
                    
                              Row(
                                children: const [
                                  Icon(Icons.phone, size: 12, color: Colors.green),
                                  SizedBox(width: 5),
                                  Text(
                                    "782222222",
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
                                children: const [
                                  Icon(
                                    Icons.cake_outlined,
                                    size: 12,
                                    color:  kFontColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "30 Years",
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
                              children:  [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, SessionsPage.id);
                                  },
                                  child: SizedBox(
                                    width: 100,
                                    height: 20,
                                    child:const Text(
                                      " قائمة الجلسات",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: kFontColor,
                                        
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                    
                            Container(
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
                                onPressed: ()
                                {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SendMessageDialog(
                                        patientName: 'أحمد محمد',
                                        phone: '+967777123456',
                                        appointmentTime: '5:00 مساءً',
                                      );
                                    },
                                  );
                                
                                },
                                                         icon: const  Icon(  Icons.chat,
                              color:Color(0xFFD6A857),
                              size: 30,
                               )
                                ),
                            ),
                    
                           
                    
                          ],
                        ),
                    
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                           
                                IconButton(
                                onPressed: ()
                                {
                                  Navigator.pushNamed(context, EditDataPatientPage.id);
                                },
                           icon: const  Icon(   Icons.arrow_forward_ios,
                              color:Color(0xFFD6A857),
                              size: 18,
                               )
                                )
                          ],
                        )
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
