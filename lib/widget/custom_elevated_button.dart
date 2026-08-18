import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.backgroundcolor,
    required this.text, 
     this.textcolor,
      this.borderColor,
       this.iconColor,
  });

  final void Function()? onPressed;
  final IconData icon;
  final Color backgroundcolor;
  final String text;
  final Color? textcolor;
  final Color? borderColor;
  final Color?iconColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color:iconColor?? Colors.white, size: 20),
      label: Text(
        text,
        style: TextStyle(color:textcolor?? Colors.white,
         fontWeight: FontWeight.bold,
         fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundcolor,
        elevation:1,
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: borderColor != null
            ? BorderSide(color: borderColor!, width: 2)
            : BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14
        )),
      ),
    );
  }
}
