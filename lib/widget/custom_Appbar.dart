
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.title, this.isMainPage= false});
  final String title;
  final bool isMainPage ; // Default value is false

  Future<void> _showExitDialog(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: const Text(
              'تأكيد الخروج',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xff8F6337),
              ),
            ),
            content: const Text(
              'هل أنت متأكد من رغبتك في إغلاق التطبيق؟',
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'إلغاء',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6A857),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'نعم، خروج',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (shouldExit == true) {
      SystemNavigator.pop();
    }
  }
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
              onPressed: () 
              {
                if (isMainPage) {
                  _showExitDialog(context);
                } else {
                  Navigator.pop(context);
                }
              },
              icon:  Icon( isMainPage ? Icons.exit_to_app :
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
