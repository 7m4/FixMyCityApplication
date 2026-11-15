import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import 'report_history_screen.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({required this.report, super.key});
  final Map<String, dynamic> report;

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(title: const Text('تفاصيل البلاغ')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(report['title']?.toString() ?? 'بلاغ', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
          const SizedBox(height: 12),
          Text('رقم البلاغ: ${report['id'] ?? '-'}', textDirection: TextDirection.ltr, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text('الحالة: ${report['status'] ?? 'قيد المراجعة'}'),
        ])),
        const SizedBox(height: 14),
        _detail('وصف البلاغ', report['description']?.toString() ?? 'لا يوجد وصف'),
        _detail('فئة البلاغ', report['category']?.toString() ?? '-'),
        _detail('الموقع', report['location']?.toString() ?? '-'),
        _detail('القسم المسؤول', report['department']?.toString() ?? '-'),
        _detail('تاريخ الإنشاء', report['date']?.toString() ?? '-'),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportHistoryScreen(report: report))),
          icon: const Icon(Icons.timeline),
          label: const Text('عرض سجل حالة البلاغ'),
        ),
      ]),
    ));
  }

  Widget _detail(String title, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: AppColors.text, fontSize: 12)),
      const SizedBox(height: 7),
      Text(value, style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.w600, height: 1.6)),
    ])),
  );
}