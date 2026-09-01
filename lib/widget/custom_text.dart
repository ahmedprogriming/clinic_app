
import 'package:clinic_app/Constant.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,required this.text,
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right:16),
      child: Text(text! ,
      style: TextStyle(
        fontSize: 12,
        color:kFontColor,
        fontWeight: FontWeight.bold,
      ),),
    );
  }
}