import 'package:clinic_app/constant.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    this.hint,
    this.maxLines = 1,
    this.onSave,
    this.onChanged,
    this.initialValue,
  });

  final String? hint;
  final int? maxLines;
  final void Function(String?)? onSave;
  final void Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      onSaved: onSave,
      validator: (value) {
        if(value?.isEmpty ?? true)
        {
          return 'The filed is required';
        }
        else
        {
          return null;
        }
      },
      cursorColor: const Color(0xffAE7733),
      //textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color:Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color:Color(0xffAE7733)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color:Color(0xffAE7733)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color:Color.fromARGB(255, 110, 61, 1)),
        ),
      ),
    );
  }
}
