import 'package:clinic_app/Constant.dart';
import 'package:flutter/material.dart';

class CustomSmallContaner extends StatelessWidget {
  const CustomSmallContaner({
    super.key,
    required this.textTop,
    required this.textbottom,
    required this.icon,
  });

  final String textTop;
  final String textbottom;

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: gold.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Icon(icon.icon, color: fontc),
          const SizedBox(height: 5),

          Text(textTop, style: TextStyle(color: fontc)),
          const SizedBox(height: 3),
          Text(
            textbottom,
            style: TextStyle(color: darkGold, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
