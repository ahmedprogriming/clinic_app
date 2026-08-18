import 'package:clinic_app/constant.dart';
import 'package:flutter/material.dart';

class AddImageItem extends StatelessWidget {
  const AddImageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
       
        width: double.infinity,
      height: 125,
        decoration: BoxDecoration(
          color: const Color(0xffFFFBF5) ,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffE6D8C0),)
        ),
      
        child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            color: Color(0xffB08D57),
            size: 25,
          ),
          SizedBox(height: 10),
          Text(
            'إضافة',
            style: TextStyle(
              color: Color(0xffB08D57),
            ),
          ),
        ],
      ),
      ),
    );
  }
}