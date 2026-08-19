import 'package:clinic_app/constant.dart';
import 'package:clinic_app/widget/add_image_Item.dart';
import 'package:clinic_app/widget/custom_elevated_button.dart';
import 'package:clinic_app/widget/note_Item.dart';
import 'package:clinic_app/widget/session_Item.dart';
import 'package:flutter/material.dart';

class DetailSession extends StatelessWidget {
  const DetailSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: const Color(0xffE9D9BD)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),

              child: Column(
                //Headres
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    color: const Color(0xffFCF8EF),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //number session
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              'الجلسة رقم',
                              style: TextStyle(
                                color: Color(0xffA98258),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '#12',
                              style: TextStyle(
                                color: Color(0xff3D291C),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        //State
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffEDF5EF),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Text(
                            'مكتملة',
                            style: TextStyle(
                              color: Color(0xff55705B),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Detailes Session
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                    child: Column(
                      children: [
                        SessionItem(
                          icon: Icons.calendar_month_outlined,
                          title: 'التاريخ',
                          value: '8 أغسطس 2026',
                        ),

                        SessionItem(
                          icon: Icons.access_time_outlined,
                          title: 'الوقت',
                          value: '5:00 مساءً - 30 دقيقة',
                        ),

                        SessionItem(
                          icon: Icons.medical_services_outlined,
                          title: 'نوع الجلسة',
                          value: 'حجامة',
                        ),

                        SessionItem(
                          icon: Icons.location_on_outlined,
                          title: 'الموقع',
                          value: 'الظهر والكتفين',
                        ),

                        
                        SessionItem(
                          icon: Icons.person,
                          title: 'المعالج',
                          value: 'الدكتور حسن',
                        ),

                      ],
                    ),
                  ),

                  // ================= BOTTOM =================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Divider(color: Color(0xffE8DCCB), height: 1),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'المريضة',
                          style: TextStyle(
                            color: Color(0xffA98258),
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'سارة محمد العتيبي',
                          style: TextStyle(
                            color: Color(0xff3D291C),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined, color: fontc, size: 20),
                const SizedBox(width: 10),

                Text(
                  'الصور المرفقة',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Row(
            spacing: 5,
            children: [
              Expanded(child: AddImageItem()),
              Expanded(child: AddImageItem()),
              Expanded(child: AddImageItem()),
            ],
          ),
          const SizedBox(height: 20),

          //Records notes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.note_alt_outlined, color: fontc, size: 20),
                const SizedBox(width: 10),

                Text(
                  'سجل الملاحظات',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              NoteItem(
                doctor: 'المعالج أحمد',
                date: '8 أغسطس 2026 — 5:40 مساء',
                note:
                    'تحسن ملحوظ في آلام الكتف بعد الجلسة، ينصح بمتابعة الكمادات الدافئة.',
              ),

              NoteItem(
                doctor: 'المعالج أحمد',
                date: '8 أغسطس 2026 — 5:15 مساء',
                note: 'تم وضع الكمادات على الظهر والكتفين لمدة 10 دقائق.',
              ),

              NoteItem(
                doctor: 'المعالجة مريم',
                date: '24 يوليو 2026 — 7:00 مساء',
                note:
                    'ملاحظة سابقة: استجابة جيدة للجلسة المزدوجة، يوصى بجلسة متابعة بعد أسبوعين.',
                isLast: true,
              ),

              SizedBox(height: 20),

              Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              SizedBox(
                width: 160,
                height: 55,
                child: CustomElevatedButton(
                  icon: Icons.edit,
                  backgroundcolor: darkGold,
                  text: 'تعديل الجلسة',
                   onPressed: ()
                   {
                Navigator.pop(context);
                   },
                ),
              ),
           const   SizedBox(width: 10),
              SizedBox(
                width: 160,
                height: 55,
                child: CustomElevatedButton(
                  icon: Icons.delete,
                  backgroundcolor: Colors.white,
                  text: 'الغاء',
                  textcolor: darkGold,
                  borderColor:  const Color(0xffE9D9BD),
                  iconColor: gold,
                  onPressed: ()
                   {
                Navigator.pop(context);
                   },
                ),
              ),
            ],
          ),
       

              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
