import 'package:fix_my_city_application/core/widgets/status_box.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';

class ReportHistoryScreen extends StatelessWidget {
  const ReportHistoryScreen({required this.report, super.key});
  final Map<String, dynamic> report;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'سجل حالات البلاغ',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontFamily:
                  'Cairo', // Make sure Cairo is registered in pubspec.yaml
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          backgroundColor: AppColors.primary,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("رقم البلاغ# ${report['id']}"),
                const SizedBox(height: 15),
                _historyRecord(report),
                const SizedBox(height: 15),
                _historyRecord(report),
                const SizedBox(height: 15),
                _historyRecord(report),
                const SizedBox(height: 15),
                _historyRecord(report),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _historyRecord(Map<String, dynamic> report) {
  return AppCard(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(report['date']),
            StatusBox(textStatus: report['status'?.toString() ?? '-']),
          ],
        ),
        SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ملاحظات العملية'),
            SizedBox(height: 7),

            Text('هنا سيتم عرض الملاحظات التي نتجت عن هذه العملية نفسها'),

            (report['status'] != 'rejected')
                ? Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x17FF0000),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Padding(padding: EdgeInsets.all(4)),
                    width: double.infinity,
                  )
                : Text("data"),
          ],
        ),
      ],
    ),
  );
}
