import 'package:clinic_app/constant.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    super.key,
    this.hint,
    this.maxLines = 1,
    this.onSave,
    this.initialValue,
    this.textdecoration,
    this.obsecureText = false,
    this.showPasswordIcon = false,
    this.width,
    this.height,
    this.hintColor,
    this.bordercolor,
    this.icon,
     this.fillcolor, this.fontsizehint,
       this.readonly=false,
        this.onTap, this.controller, 
        this.onChange,
  });

  final String? hint;
  final int? maxLines;
  final void Function(String?)? onSave;
  
  final String? initialValue;
  final TextDecoration? textdecoration;
  final bool obsecureText;
  final bool showPasswordIcon;
  final double? width;
  final double? height;
  final Color? hintColor;
  final Color? bordercolor;
  final IconData? icon;
  final Color? fillcolor;
  final double? fontsizehint;
  final bool readonly;
  final void Function()? onTap;
  final TextEditingController? controller;
  final Function(String)? onChange;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
    late bool isObsecure;

  @override
  void initState() {
    super.initState();
    isObsecure = widget.obsecureText;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
    
        initialValue: widget.initialValue,
          onChanged: widget.onChange,
        onSaved: widget.onSave,
        obscureText: isObsecure,
        readOnly: widget.readonly,
        onTap: widget.onTap,
        controller:widget.controller ,
        

        textDirection: widget.textdecoration == TextDecoration.none
            ? TextDirection.rtl
            : TextDirection.ltr,

        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'The filed is required';
          } else {
            return null;
          }
        },
        cursorColor: kFontColor,
        //textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor:widget.fillcolor??kPrimaryColor,
          hintText: widget.hint,
          
          prefixIcon: Icon(widget.icon, color: Color(0xffC1AD94), size: 20),
          hintTextDirection: TextDirection.ltr,

          suffixIcon: widget.showPasswordIcon
              ? IconButton(
                  onPressed: ()
                  {
                    
                  setState(() {
                    isObsecure=!isObsecure;
                  });
                  },
                  icon: Icon(
                    isObsecure ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
          hintStyle: TextStyle(color: widget.hintColor ?? Colors.black, fontSize:widget.fontsizehint?? 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: widget.bordercolor ?? kFontColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: widget.bordercolor ?? kFontColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: kFontColor),
          ),
        ),
      ),
    );
  }
}
