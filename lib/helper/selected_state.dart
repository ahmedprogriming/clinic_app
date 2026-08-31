import 'dart:ui';

// Background badge color (light tint)
Color selectBadgeBgColor(String state) {
  switch (state.trim()) {
    case 'مكتملة':
      return const Color(0xffEDF5EF); // Soft green
    case 'قادمة':
      return const Color(0xffFFF7E6); // Soft amber
    case 'ملغاة':
      return const Color(0xffFDEEEC); // Soft red
    default:
      return const Color(0xffF2F4F1);
  }
}

// Text & border color (darker, high-contrast)
Color selectBadgeTextColor(String state) {
  switch (state.trim()) {
    case 'مكتملة':
      return const Color(0xff55705B); // Dark green
    case 'قادمة':
      return const Color(0xffC48B28); // Dark amber/gold
    case 'ملغاة':
      return const Color(0xffD32F2F); // Dark red
    default:
      return const Color(0xff666666);
  }
}