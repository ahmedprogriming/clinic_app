import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendMessageDialog extends StatefulWidget {
  final String patientName;
  final String phone;
  final String appointmentTime;

  const SendMessageDialog({
    super.key,
    required this.patientName,
    required this.phone,
    required this.appointmentTime,
  });

  @override
  State<SendMessageDialog> createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends State<SendMessageDialog> {
  late TextEditingController messageController;

  // التواصل مع Android Native
  static const MethodChannel _channel = MethodChannel('clinic_app/whatsapp');

  final Color gold = const Color(0xFFD6A857);
  final Color darkGold = const Color(0xFF8B6B2E);
  final Color cream = const Color(0xFFFAF7F1);

  @override
  void initState() {
    super.initState();

    messageController = TextEditingController(text: _defaultMessage());
  }

  String _defaultMessage() {
    return '''
السلام عليكم ${widget.patientName} 🌿

نذكركم بأن لديكم موعدًا اليوم في عيادة الحجامة والمساج الساعة ${widget.appointmentTime}.

نتمنى لكم دوام الصحة والعافية 🤍
''';
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  // تنظيف رقم الهاتف
  String _cleanPhoneNumber(String phone) {
    String number = phone.trim();

    // إزالة المسافات والرموز
    number = number.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // تحويل 00 إلى +
    if (number.startsWith('00')) {
      number = '+${number.substring(2)}';
    }

    // wa.me لا يحتاج +
    number = number.replaceAll('+', '');

    return number;
  }

  // فتح واتساب بدون url_launcher
  Future<void> _openWhatsApp() async {
    final phone = _cleanPhoneNumber(widget.phone);

    if (phone.isEmpty) {
      _showError('رقم الهاتف غير صحيح');
      return;
    }

    final message = messageController.text.trim();

    // إنشاء رابط WhatsApp
    final Uri whatsappUri = Uri.https('wa.me', '/$phone', {'text': message});

    try {
      final bool? result = await _channel.invokeMethod<bool>('openWhatsApp', {
        'url': whatsappUri.toString(),
      });

      if (result != true && mounted) {
        _showError('تعذر فتح واتساب');
      }
    } on PlatformException {
      if (mounted) {
        _showError('حدث خطأ أثناء فتح واتساب');
      }
    } catch (e) {
      if (mounted) {
        _showError('حدث خطأ أثناء فتح واتساب');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, textDirection: TextDirection.rtl)),
    );
  }

  void _showPreview() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('معاينة الرسالة', textAlign: TextAlign.right),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(messageController.text),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إغلاق', style: TextStyle(color: darkGold)),
            ),
          ],
        );
      },
    );
  }

  void _selectTemplate(String type) {
    String message = '';

    switch (type) {
      case 'today':
        message =
            '''
السلام عليكم ${widget.patientName} 🌿

نذكركم بأن لديكم موعدًا اليوم في عيادة الحجامة والمساج الساعة ${widget.appointmentTime}.

نتمنى لكم دوام الصحة والعافية 🤍
''';
        break;

      case 'tomorrow':
        message =
            '''
السلام عليكم ${widget.patientName} 🌿

نذكركم بأن لديكم موعدًا غدًا في عيادة الحجامة والمساج الساعة ${widget.appointmentTime}.

نتمنى لكم دوام الصحة والعافية 🤍
''';
        break;

      case 'clinic':
        message =
            '''
السلام عليكم ${widget.patientName} 🌿

نود تذكيركم بأن عيادة الحجامة والمساج مفتوحة اليوم.

نسعد بخدمتكم 🤍
''';
        break;

      case 'follow':
        message =
            '''
السلام عليكم ${widget.patientName} 🌿

نود الاطمئنان عليكم بعد جلستكم الأخيرة في عيادة الحجامة والمساج.

نتمنى لكم دوام الصحة والعافية 🤍
''';
        break;
    }

    setState(() {
      messageController.text = message;
      messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: messageController.text.length),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),

        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: gold.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.send_rounded, color: gold, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'إرسال تذكير',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: darkGold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: cream,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: gold.withOpacity(0.2)),
                  ),

                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: gold.withOpacity(0.18),
                        child: Icon(Icons.person, color: darkGold),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.patientName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.phone,
                              style: TextStyle(color: Colors.grey.shade600),
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Template
                Text(
                  'قالب الرسالة',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: darkGold,
                  ),
                ),

                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: 'today',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: gold.withOpacity(0.35)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: gold.withOpacity(0.35)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: gold),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'today',
                      child: Text('تذكير بموعد اليوم'),
                    ),
                    DropdownMenuItem(
                      value: 'tomorrow',
                      child: Text('تذكير بموعد الغد'),
                    ),
                    DropdownMenuItem(
                      value: 'clinic',
                      child: Text('العيادة مفتوحة اليوم'),
                    ),
                    DropdownMenuItem(
                      value: 'follow',
                      child: Text('متابعة بعد الجلسة'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _selectTemplate(value);
                    }
                  },
                ),
                const SizedBox(height: 18),

                // Message
                Text(
                  'نص الرسالة',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: darkGold,
                  ),
                ),
                const SizedBox(height: 8),

                TextFormField(
                  controller: messageController,
                  maxLines: 7,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: 'اكتب الرسالة هنا...',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: gold.withOpacity(0.35)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: gold.withOpacity(0.35)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: gold, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Preview
                OutlinedButton.icon(
                  onPressed: _showPreview,
                  icon: const Icon(Icons.visibility_outlined),
                  label: const Text('معاينة الرسالة'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: darkGold,
                    side: BorderSide(color: gold.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                ),
                const SizedBox(height: 18),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close, size: 19),
                        label: const Text('إلغاء'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: _openWhatsApp,
                        icon: const Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'فتح واتساب',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
