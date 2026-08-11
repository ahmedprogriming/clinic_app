import 'package:clinic_app/constant.dart';
import 'package:flutter/material.dart';

class RecordsSessionPatient extends StatelessWidget {
  const RecordsSessionPatient({
    super.key,
    required this.textTop,
    required this.textbottom,
  });
  final String textTop;
  final String textbottom;
  //final Color closeSession=Color(0xffF8ECE8);
  //final Color waitSession=Color(0xffF3EDE0);
  //final Color completSession=Color(0xffEDF4EC);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: gold.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textTop,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                 const SizedBox(width: 20),
            
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xffEDF4EC)
                  ),
                  child: Text(' مكتملة'),
                 )
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timeline_outlined, color: fontc),
              const SizedBox(width: 5),
              Text(textbottom, style: TextStyle(color: fontc)),
            ],
          ),
          const SizedBox(height: 10),
         
        ],
      ),
    );
  }
}
