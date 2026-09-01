import 'package:clinic_app/Constant.dart';
import 'package:clinic_app/helper/selected_state.dart';
import 'package:clinic_app/screens/details_session_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecordsSessionPatient extends StatelessWidget {
  const RecordsSessionPatient({
    super.key,
    required this.textTop,
    required this.textbottom,
    required this.state, required this.sessionId,
  });

  final String textTop;
  final String textbottom;
  final String state;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        height: 110, // قللنا ارتفاع الكرت
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: gold.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // السطر العلوي
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // حالة الجلسة
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: selectBadgeBgColor(state),
                  ),
                  child: Text(state, style: TextStyle(fontSize: 14)),
                ),

                // رقم الجلسة
                Text(
                  textTop,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),

            // السطر السفلي
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // السهم
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.pushNamed(context, DetailsSessionPage.id,arguments: sessionId,);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFFD6A857),
                    size: 18,
                  ),
                ),

                // التاريخ
                Row(
                  children: [
                    Text(
                      textbottom,
                      style: TextStyle(color: fontc, fontSize: 14),
                    ),

                    const SizedBox(width: 5),
                    const FaIcon(
                      FontAwesomeIcons.clock,
                      color: fontc,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
