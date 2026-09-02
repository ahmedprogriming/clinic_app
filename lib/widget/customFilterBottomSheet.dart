import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? selectedCity;
  final ValueChanged<String?> onFilterApplied;

  const FilterBottomSheet({
    super.key,
    required this.selectedCity,
    required this.onFilterApplied,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String? _currentSelection;

  final List<Map<String, dynamic>> _filterOptions = const [
    {'title': 'جميع المناطق', 'value': null, 'icon': Icons.location_city_rounded},
    {'title': 'تريم', 'value': 'تريم', 'icon': Icons.location_on_outlined},
    {'title': 'سيئون', 'value': 'سيؤن', 'icon': Icons.location_on_outlined},
  ];

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.selectedCity;
  }

  @override
  Widget build(BuildContext context) {
    const primaryGold = Color(0xffB2935B);
    const bgCream = Color(0xffFDF9F1);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // مقبض السحب العلوي
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // عنوان النافذة وزر الإلغاء
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.tune_rounded, color: primaryGold, size: 22),
                    SizedBox(width: 8),
                    Text(
                      'تصفية حسب المنطقة',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff211A16),
                      ),
                    ),
                  ],
                ),
                if (_currentSelection != null)
                  TextButton(
                    onPressed: () {
                      setState(() => _currentSelection = null);
                      widget.onFilterApplied(null);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'إعادة ضبط',
                      style: TextStyle(color: Colors.redAccent, fontSize: 13),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // قائمة الخيارات بتصميم بطاقات مخصصة
            Column(
              children: _filterOptions.map((option) {
                final isSelected = _currentSelection == option['value'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() => _currentSelection = option['value']);
                      widget.onFilterApplied(option['value']);
                      Navigator.pop(context);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? bgCream : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? primaryGold : Colors.grey.shade200,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            option['icon'] as IconData,
                            color: isSelected ? primaryGold : Colors.grey.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            option['title'] as String,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? const Color(0xff211A16) : Colors.black87,
                            ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle_rounded,
                              color: primaryGold,
                              size: 22,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}