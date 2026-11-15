import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class SectionTitle extends StatelessWidget {
  final String title; final String? subtitle;
  const SectionTitle({super.key, required this.title, this.subtitle});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
    if (subtitle != null) ...[const SizedBox(height: 6), Text(subtitle!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary))],
  ]);
}