
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFD6A857).withValues(alpha: 0.15),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back, // Points correctly for RTL
                color: Color(0xFFD6A857),
                size: 18,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(0xff8F6337),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 40,
          ), // Balances the space opposite the back button
        ],
      ),
    );
  }
}
