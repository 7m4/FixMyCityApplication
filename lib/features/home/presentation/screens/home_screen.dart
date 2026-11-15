import 'package:flutter/material.dart';
import '../../../../core/testing/test_data_loader.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../reports/presentation/screens/report_details_screen.dart';
import '../../../reports/presentation/widgets/report_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.onOpenReports, required this.onCreateReport, super.key});
  final VoidCallback onOpenReports;
  final VoidCallback onCreateReport;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('FixMyCity')),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: TestDataLoader.loadList('reports.json'),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Center(child: Text('تعذّر تحميل بيانات التجربة.'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        final reports = snapshot.data!;
        final active = reports.where((r) => r['status'] != 'تم الحل').length;
        final completed = reports.length - active;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          children: [
            const Text('مرحباً، أحمد', style: TextStyle(color: AppColors.navy, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text('إليك ملخص بلاغاتك الأخيرة.', style: TextStyle(color: AppColors.text)),
            const SizedBox(height: 18),
            AppCard(
              padding: const EdgeInsets.all(18),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('إجمالي البلاغات', style: TextStyle(color: Colors.white70)),
                Text('${reports.length}', style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
                Row(children: [
                  _statChip('$active قيد المعالجة'.replaceFirst('$', ''), Colors.white),
                  const SizedBox(width: 8),
                  _statChip('$completed مكتمل'.replaceFirst('$', ''), Colors.white),
                ]),
              ]),
            ),
            const SizedBox(height: 22),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('البلاغات الأخيرة', style: TextStyle(color: AppColors.navy, fontSize: 17, fontWeight: FontWeight.bold)),
              TextButton(onPressed: onOpenReports, child: const Text('عرض الكل')),
            ]),
            if (reports.isEmpty)
              const AppCard(child: Text('لا توجد بلاغات حتى الآن. ابدأ بإرسال بلاغ جديد.'))
            else
              ...reports.take(3).map((report) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ReportCard(
                  report: report,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportDetailsScreen(report: report))),
                ),
              )),
          ],
        );
      },
    ),
  );

  Widget _statChip(String label, Color textColor) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(color: const Color(0xFF1C7578), borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold)),
  );
}