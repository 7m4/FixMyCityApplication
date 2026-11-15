import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../home/presentation/screens/app_shell.dart';
import '../../../reports/presentation/screens/report_details_screen.dart';

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({required this.report, super.key});
  final Map<String, dynamic> report;

  @override
  Widget build(BuildContext context) {
    final trackingNumber = report['id']?.toString() ?? '';
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
        children: [
          const Center(child: Icon(Icons.check_circle, color: AppColors.success, size: 112)),
          const SizedBox(height: 24),
          const Text('تم إرسال بلاغك بنجاح!', textAlign: TextAlign.center, style: TextStyle(color: AppColors.navy, fontSize: 23, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('شكراً لمساهمتك. تم تسجيل البلاغ محلياً في نسخة التجربة.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.text, height: 1.7)),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(14)),
            child: Column(children: [
              const Text('رقم تتبع البلاغ', style: TextStyle(color: AppColors.text)),
              const SizedBox(height: 12),
              SelectableText(trackingNumber, textDirection: TextDirection.ltr, style: const TextStyle(color: AppColors.primary, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('احتفظ بهذا الرقم لمتابعة حالة البلاغ.', style: TextStyle(color: AppColors.text, fontSize: 12)),
            ]),
          ),
          const SizedBox(height: 14),
          AppButton(label: 'نسخ رقم التتبع', outlined: true, icon: Icons.copy, onPressed: () {
            Clipboard.setData(ClipboardData(text: trackingNumber));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نسخ رقم التتبع')));
          }),
          const SizedBox(height: 12),
          AppButton(label: 'عرض تفاصيل البلاغ', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportDetailsScreen(report: report)))),
          const SizedBox(height: 10),
          TextButton(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AppShell()), (route) => false), child: const Text('العودة إلى الرئيسية')),
        ],
      )),
    ));
  }
}