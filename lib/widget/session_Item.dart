import 'package:flutter/material.dart';
class SessionItem extends StatelessWidget {
  const SessionItem({super.key, required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // الأيقونة
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xffFBF4E7),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: const Color(0xffB58A4D), size: 25),
        ),

        const SizedBox(width: 12),

        // النص
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Color(0xffA98258), fontSize: 13),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xff3D291C),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  }
}
