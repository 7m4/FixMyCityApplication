import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class StatusChip extends StatelessWidget {
  final String status; const StatusChip({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    final color = switch (status) {'تم الحل' => AppColors.success, 'مرفوض' => AppColors.error, 'قيد التنفيذ' => AppColors.primary, _ => AppColors.warning};
    return Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.09), borderRadius: BorderRadius.circular(8)),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)));
  }
}