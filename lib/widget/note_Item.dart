import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.doctor,
    required this.date,
    required this.note,
    this.isLast = false,
  });
  final String doctor;
  final String date;
  final String note;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الخط والدوائر
        SizedBox(
          width: 18,
          child: Column(
            children: [
              Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffB08D57), width: 2),
                ),
              ),

              if (!isLast)
                Container(
                  width: 1,
                  height: 110,
                  color: const Color(0xffE0D2BA),
                ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xffE6D8C0)),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      doctor,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff6B4F2A),
                      ),
                    ),

                    Text(
                      date,
                      style: const TextStyle(
                        color: Color(0xff9A7B52),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Text(
                  note,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 14, height: 1.7),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
