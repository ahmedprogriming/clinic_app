
import 'package:clinic_app/constant.dart';
import 'package:flutter/material.dart';

class CustomWidgetTitleElement extends StatelessWidget {
  const CustomWidgetTitleElement({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Icon(icon, color: gold, size: 17),
        SizedBox(width: 5),
         Text(
         text,
          style: TextStyle(color: darkGold, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}