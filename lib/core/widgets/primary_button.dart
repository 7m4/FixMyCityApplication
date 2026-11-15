import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class PrimaryButton extends StatelessWidget {
  final String label; final VoidCallback? onPressed;
  const PrimaryButton({super.key, required this.label, required this.onPressed});
  @override
  Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 56,
    child: ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))));
}