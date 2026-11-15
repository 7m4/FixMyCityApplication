import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({required this.report, required this.onTap, super.key});
  final Map<String, dynamic> report;
  final VoidCallback onTap;

  Color get _statusColor {
    switch (report['status']) {
      case 'تم الحل': return AppColors.success;
      case 'مرفوض': return AppColors.error;
      default: return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(report['title']?.toString() ?? 'بلاغ', style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 15))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(color: _statusColor.withValues(alpha: .09), borderRadius: BorderRadius.circular(8)),
                child: Text(report['status']?.toString() ?? 'قيد المراجعة', style: TextStyle(color: _statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ]),
            const SizedBox(height: 8),
            Text('رقم البلاغ: ${report['id'] ?? '-'}', textDirection: TextDirection.ltr, style: const TextStyle(color: AppColors.text, fontSize: 11)),
            const SizedBox(height: 8),
            Row(children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.text),
              const SizedBox(width: 4),
              Expanded(child: Text(report['location']?.toString() ?? '', style: const TextStyle(color: AppColors.text, fontSize: 12))),
            ]),
            const SizedBox(height: 4),
            Text(report['date']?.toString() ?? '', style: const TextStyle(color: AppColors.hint, fontSize: 11)),
          ]),
        ),
      ),
    );
  }
}