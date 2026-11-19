import 'package:fix_my_city_application/core/widgets/status_box.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import 'report_history_screen.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({required this.report, super.key});
  final Map<String, dynamic> report;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FixMyCity',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'تفاصيل البلاغ',
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            AppCard(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('رقم البلاغ:'),
                      SizedBox(height: 10),
                      Text(
                        report['id']?.toString() ?? '-',
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('حالة البلاغ:'),
                      SizedBox(height: 10),

                      //StatusBox(Status.solved), // Replace with the actual status from the report
                      StatusBox(textStatus: report['status']),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _detail(
              'ملاحظات الجهة',
              report['description']?.toString() ?? 'لا توجد ملاحظات',
            ),

            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("صورة المشكلة"),
                  SizedBox(height: 7),
                  Image.asset('images/splash_logo.png', height: 50),
                  SizedBox(height: 7),
                  Divider(color: Color(0x17151515)),
                  Text("معاينة الصورة"),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // here the image of problem will be added
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "وصف البلاغ",
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      report['description']?.toString() ?? 'لا يوجد وصف',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                    // const SizedBox(height: 7,),
                    Divider(color: Color(0xFFD9E3E7)),
                    Text(
                      "فئة البلاغ",
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      report['category']?.toString() ?? 'لم يتم التحديد',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/logo.png', height: 20),
                    SizedBox(height: 15),
                    Text(
                      "العنوان",
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      report['location']?.toString() ?? '-',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                    Divider(color: Color(0xFFD9E3E7)),
                    Text(
                      "معلم قريب",
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      report['location']?.toString() ?? '-',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الجهة المسؤولة عن البلاغ",
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      report['department']?.toString() ?? '-',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                    Divider(color: Color(0xFFD9E3E7)),
                    Text(
                      "تاريخ انشاء البلاغ",
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      report['date']?.toString() ?? '-',
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReportHistoryScreen(report: report),
                ),
              ),
              icon: const Icon(Icons.timeline),
              label: const Text('عرض سجل حالة البلاغ'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(String title, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.text, fontSize: 12),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.w600,
              height: 1.6,
            ),
          ),
        ],
      ),
    ),
  );
}
