import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/employee_reports_data.dart';

class DuplicateReportsScreen extends StatelessWidget {
  const DuplicateReportsScreen({
    super.key,
    required this.reports,
    required this.onReviewReport,
    this.primaryReportId = 'FMC-2026-1042',
    this.onBack,
  });

  final List<SampleReport> reports;
  final String primaryReportId;
  final ValueChanged<SampleReport> onReviewReport;
  final VoidCallback? onBack;


  @override
  Widget build(BuildContext context) {
    final primaryReport = reports.firstWhere(
      (report) => report.id == primaryReportId,
      orElse: () => reports.first,
    );
    final duplicateReports = primaryReport.possibleDuplicateIds
        .map((id) => reports.where((report) => report.id == id))
        .where((matches) => matches.isNotEmpty)
        .map((matches) => matches.first)
        .toList();
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _header(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'البلاغات المكررة',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'راجع البلاغات المتشابهة قبل ربطها',
                textAlign: TextAlign.right,
                style: TextStyle(color: AppColors.text, fontSize: 13),
              ),
              if (onBack != null) ...[
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_forward, size: 17),
                    label: const Text('العودة إلى تفاصيل البلاغ'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
              const SizedBox(height: 16),
              _sectionHeading('البلاغ الأساسي', Icons.assignment_outlined),
              const SizedBox(height: 10),
              _primaryCard(primaryReport),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'بلاغات محتمل تكرارها',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${duplicateReports.length} بلاغات',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...duplicateReports.map((report) => _candidateCard(report)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7E8),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: const Color(0xFFF1D9A8)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: AppColors.warning, size: 20),
                    SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'لن يتم ربط أي بلاغ قبل مراجعته وتأكيدك. يمكنك مراجعة تفاصيل كل بلاغ قبل اتخاذ القرار.',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 12,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'نموذج تجريبي · بيانات افتراضية',
                  style: TextStyle(color: AppColors.hint, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'FixMyCity',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'بوابة مدير القسم',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeading(String title, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, color: AppColors.primary, size: 20),
      ],
    );
  }

  Widget _primaryCard(SampleReport primaryReport) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.primary, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusChip(primaryReport.status),
              const Text(
                'البلاغ الأساسي',
                style: TextStyle(color: AppColors.hint, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            primaryReport.title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            primaryReport.id,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          _infoRow(Icons.location_on_outlined, primaryReport.location),
          const SizedBox(height: 5),
          _infoRow(Icons.calendar_today_outlined, primaryReport.date),
        ],
      ),
    );
  }

  Widget _candidateCard(SampleReport report) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  report.duplicateDistance.isEmpty ? 'بلاغ مرتبط' : 'يبعد ${report.duplicateDistance}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _statusChip(report.status),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            report.title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            report.id,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            style: const TextStyle(color: AppColors.hint, fontSize: 11),
          ),
          const SizedBox(height: 7),
          _infoRow(Icons.location_on_outlined, report.location),
          const SizedBox(height: 7),
          Text(
            report.duplicateSimilarity,
            textAlign: TextAlign.right,
            style: const TextStyle(color: AppColors.text, fontSize: 11),
          ),
          const SizedBox(height: 13),
          OutlinedButton.icon(
            onPressed: () => onReviewReport(report),
            icon: const Icon(Icons.arrow_back, size: 17),
            label: const Text('مراجعة البلاغ المحتمل تكراره'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.right,
            style: const TextStyle(color: AppColors.text, fontSize: 11),
          ),
        ),
        const SizedBox(width: 6),
        Icon(icon, color: AppColors.hint, size: 15),
      ],
    );
  }

  Widget _statusChip(String status) {
    final Color foreground;
    final Color background;
    switch (status) {
      case 'تم الحل':
        foreground = AppColors.success;
        background = const Color(0xFFEAF3EE);
        break;
      case 'بانتظار الموافقة':
        foreground = AppColors.warning;
        background = const Color(0xFFF8F0E2);
        break;
      case 'مرفوض':
        foreground = AppColors.error;
        background = const Color(0xFFFCEDEC);
        break;
      default:
        foreground = AppColors.primary;
        background = AppColors.primaryLight;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
