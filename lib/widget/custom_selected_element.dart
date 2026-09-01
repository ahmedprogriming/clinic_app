import 'package:clinic_app/Constant.dart';
import 'package:flutter/material.dart';

class CustomSelectedElement extends StatelessWidget {
  const CustomSelectedElement({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
             color: isSelected
              ? const Color(0xffF3E6D0)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? 
          fontc : Color(0xffE8DECC)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: darkGold, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
