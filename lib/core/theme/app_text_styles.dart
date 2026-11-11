import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle appBarLogo = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle stepIndicatorText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle fieldLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle fieldHint = TextStyle(
    fontSize: 14,
    color: AppColors.textHint,
  );

  static const TextStyle primaryButton = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
