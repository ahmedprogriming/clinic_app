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
    this.textdecoration,
    this.obsecureText=false, 
    this.onVisibilityPressed,
      this.showPasswordIcon=false,
      this.width,
      this.height,
      this.hintColor,
      this.bordercolor,
      this.icon,
  });

  final String? hint;
  final int? maxLines;
  final void Function(String?)? onSave;
  final void Function(String)? onChanged;
  final String? initialValue;
  final TextDecoration? textdecoration; 
  final bool? obsecureText;
  final VoidCallback? onVisibilityPressed;
final bool? showPasswordIcon;
final double? width;
  final double? height;
  final Color? hintColor;
  final Color? bordercolor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        onSaved: onSave,
        obscureText: obsecureText!,
        
        textDirection:textdecoration==TextDecoration.none?TextDirection.rtl:TextDirection.ltr,
       
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
        cursorColor: kFontColor,
        //textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
           prefixIcon: Icon(
                       icon,
                        color: Color(0xffC1AD94),
                        size: 12,
                     
                      ),
                      hintTextDirection:TextDirection.rtl,
           
           suffixIcon: showPasswordIcon!
      ? IconButton(
          onPressed: onVisibilityPressed,
          icon: Icon(
            obsecureText!
                ? Icons.visibility_off
                : Icons.visibility,
          ),
        )
      : null,
          hintStyle: TextStyle(color:hintColor ?? Colors.black,
          fontSize: 11,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(color:bordercolor ?? kFontColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(color:bordercolor ?? kFontColor), 
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:  BorderSide(color:kFontColor),
          ),
        ),
      ),
    );
  }
}
