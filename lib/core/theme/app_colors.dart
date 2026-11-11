import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // الألوان الأساسية
  static const Color primary = Color(0xFF087F78);      // الأخضر المزرق الأساسي
  static const Color background = Color(0xFFF5F6F8);   // خلفية الشاشات الرمادية الفاتحة
  static const Color surface = Colors.white;           // خلفية الحقول والبطاقات

  // ألوان النصوص
  static const Color textPrimary = Color(0xFF1A202C);  // العناوين الداكنة
  static const Color textSecondary = Color(0xFF718096);// النصوص الوصفية
  static const Color textHint = Color(0xFFA0AEC0);     // النصوص التوضيحية داخل الحقول
  static const Color textMuted = Color(0xFF5A6B6C);    // نص زر الرجوع

  // ألوان الحدود والحالات
  static const Color border = Color(0xFFE2E8F0);
  static const Color inactiveStep = Color(0xFFD9E2EC);
  static const Color error = Colors.redAccent;
}
