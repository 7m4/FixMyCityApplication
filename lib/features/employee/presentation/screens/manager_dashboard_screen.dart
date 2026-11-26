import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DashboardSampleData {
  DashboardSampleData._();

  static const employeeName = 'أحمد';
  static const departmentName = 'مديرية الأشغال العامة';

  static const totalReports = 12;
  static const completedReports = 4;
  static const inProgressReports = 5;
  static const pendingReports = 3;

  static const reports = [
    SampleReport(
      id: 'FMC-2026-1042',
      title: 'حفرة في الطريق الرئيسي',
      location: 'شارع الملك عبدالله',
      date: '09/11/2026',
      status: 'بانتظار الموافقة',
    ),
    SampleReport(
      id: 'FMC-2026-1039',
      title: 'تلف في الرصيف',
      location: 'منطقة الوسط',
      date: '08/11/2026',
      status: 'قيد العمل',
    ),
    SampleReport(
      id: 'FMC-2026-1035',
      title: 'تضرر حاجز الطريق',
      location: 'شارع الجيش',
      date: '07/11/2026',
      status: 'قيد العمل',
    ),
    SampleReport(
      id: 'FMC-2026-1028',
      title: 'هبوط في الطريق',
      location: 'حي الزهور',
      date: '05/11/2026',
      status: 'تم الحل',
    ),
  ];
}

class SampleReport {
  final String id;
  final String title;
  final String location;
  final String date;
  String status;

  SampleReport({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.status,
  });
}

class ManagerDashboardScreen extends StatefulWidget {
  const ManagerDashboardScreen({
    super.key,
    required this.reports,
    this.onReportTap,
  });

  final List<SampleReport> reports;
  final ValueChanged<SampleReport>? onReportTap;

  @override
  State<ManagerDashboardScreen> createState() =>
      _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState extends State<ManagerDashboardScreen> {
  String _selectedFilter = 'الكل';

  static const _filters = [
    'الكل',
    'بانتظار الموافقة',
    'قيد العمل',
    'المنتهية',
  ];

  List<SampleReport> get _filteredReports {
    if (_selectedFilter == 'الكل') {
      return widget.reports;
    }

    if (_selectedFilter == 'المنتهية') {
      return widget.reports
          .where((report) => report.status == 'تم الحل')
          .toList();
    }

    return widget.reports
        .where((report) => report.status == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcome(),
              const SizedBox(height: 18),
              _buildSummaryCard(),
              const SizedBox(height: 22),
              _buildReportsTitle(),
              const SizedBox(height: 12),
              _buildFilters(),
              const SizedBox(height: 14),
              _buildReportsCount(),
              const SizedBox(height: 12),
              ..._filteredReports.map(_buildReportCard),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'نموذج تجريبي · بيانات افتراضية',
                  style: TextStyle(
                    color: AppColors.hint,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'FixMyCity',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'بوابة مدير القسم',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'مرحباً، ${DashboardSampleData.employeeName}',
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${DashboardSampleData.departmentName} · ملخص بلاغات القسم',
          style: const TextStyle(color: AppColors.text, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'البلاغات المسندة للقسم',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '${DashboardSampleData.totalReports}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  DashboardSampleData.completedReports,
                  'منتهية',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryItem(
                  DashboardSampleData.inProgressReports,
                  'قيد العمل',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryItem(
                  DashboardSampleData.pendingReports,
                  'بانتظار الموافقة',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(int count, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTitle() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text(
        'قائمة البلاغات',
        style: TextStyle(
          color: AppColors.navy,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.map((filter) {
          final selected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(left: 7),
            child: ChoiceChip(
              label: Text(filter),
              selected: selected,
              onSelected: (_) => setState(() => _selectedFilter = filter),
              selectedColor: AppColors.primary,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: selected ? Colors.white : AppColors.text,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              shape: StadiumBorder(
                side: BorderSide(
                  color: selected ? AppColors.primary : AppColors.border,
                ),
              ),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReportsCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${DashboardSampleData.totalReports} بلاغاً',
          style: const TextStyle(color: AppColors.hint, fontSize: 12),
        ),
        const Text(
          'الأحدث أولاً',
          style: TextStyle(
            color: AppColors.navy,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildReportCard(SampleReport report) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => widget.onReportTap?.call(report),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    report.title,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    report.id,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(color: AppColors.hint, fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${report.location} · ${report.date}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: AppColors.text, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _buildStatusChip(report.status),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final Color background;
    final Color foreground;

    switch (status) {
      case 'بانتظار الموافقة':
        background = const Color(0xFFF8F0E2);
        foreground = AppColors.warning;
        break;
      case 'قيد العمل':
        background = AppColors.primaryLight;
        foreground = AppColors.primary;
        break;
      case 'مرفوض':
        background = const Color(0xFFFCEDEC);
        foreground = AppColors.error;
        break;
      case 'تم الحل':
        background = const Color(0xFFEAF3EE);
        foreground = AppColors.success;
        break;
      default:
        background = AppColors.primaryLight;
        foreground = AppColors.primary;
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 115),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: foreground,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
