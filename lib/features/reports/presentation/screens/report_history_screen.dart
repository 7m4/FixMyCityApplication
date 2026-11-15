import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';

class ReportHistoryScreen extends StatelessWidget {
  const ReportHistoryScreen({required this.report, super.key});
  final Map<String, dynamic> report;

  @override
  Widget build(BuildContext context) {
    final history = [
      ('تم إرسال البلاغ', 'تم تسجيل البلاغ في النظام', true),
      ('تم استلام البلاغ', 'وصل البلاغ إلى الجهة المعنية', true),
      (report['status']?.toString() ?? 'قيد المراجعة', 'الحالة الحالية للبلاغ', true),
      ('بدء المعالجة', 'بانتظار تحديث الجهة المختصة', false),
      ('تم الحل', 'بانتظار تحديث الجهة المختصة', false),
    ];
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(title: const Text('سجل حالة البلاغ')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text('رقم البلاغ: ${report['id'] ?? '-'}', textDirection: TextDirection.ltr, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ...history.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(item.$3 ? Icons.check_circle : Icons.radio_button_unchecked, color: item.$3 ? AppColors.success : AppColors.hint),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.$1, style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(item.$2, style: const TextStyle(color: AppColors.text, height: 1.5)),
            ])),
          ])),
        )),
      ]),
    ));
  }
}