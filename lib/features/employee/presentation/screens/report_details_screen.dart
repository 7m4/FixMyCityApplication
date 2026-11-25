import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'manager_dashboard_screen.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({
    super.key,
    required this.report,
    required this.onBack,
  });

  final SampleReport report;
  final VoidCallback onBack;

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'تفاصيل البلاغ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'مديرية الأشغال العامة',
                textAlign: TextAlign.right,
                style: TextStyle(color: AppColors.text),
              ),
              const SizedBox(height: 18),
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'رقم البلاغ',
                      style: TextStyle(color: AppColors.hint),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      report.id,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _statusChip(report.status),
                    const SizedBox(height: 12),
                    Text(
                      'تاريخ البلاغ: ${report.date} · 10:08 ص',
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: AppColors.text),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 42,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'موضع صورة البلاغ الأصلية',
                      style: TextStyle(color: AppColors.text),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _sectionTitle('وصف البلاغ'),
                    const SizedBox(height: 12),
                    const Text(
                      'وجود حفرة وتلف في طبقة الإسفلت تعيق حركة المركبات.',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.navy,
                        height: 1.6,
                      ),
                    ),
                    const Divider(height: 24),
                    _detailRow('نوع المشكلة', 'أضرار الطرق والحفر'),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _sectionTitle('موقع البلاغ'),
                    const SizedBox(height: 12),
                    Container(
                      height: 95,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _detailRow('الموقع', 'شارع الملك عبدالله، الزرقاء'),
                    const SizedBox(height: 8),
                    _detailRow('معلم قريب', 'بالقرب من دوار الجيش'),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _sectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _detailRow('القسم المسؤول', 'مديرية الأشغال العامة'),
                    const SizedBox(height: 10),
                    _detailRow(
                      'آخر تحديث',
                      '10 نوفمبر 2026 · 10:30 ص',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _actionButton(
                context,
                'تعديل حالة البلاغ',
                filled: true,
                onPressed: () => _showComingSoon(
                  context,
                  'شاشة تحديث حالة البلاغ قيد التجهيز.',
                ),
              ),
              const SizedBox(height: 10),
              _actionButton(
                context,
                'تحويل إلى قسم آخر',
                onPressed: () => _showComingSoon(
                  context,
                  'شاشة تحويل البلاغ قيد التجهيز.',
                ),
              ),
              const SizedBox(height: 10),
              _actionButton(
                context,
                'مراجعة البلاغات المتكررة - 2',
                onPressed: () => _showComingSoon(
                  context,
                  'شاشة مراجعة البلاغات المتكررة قيد التجهيز.',
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: onBack,
                child: const Text(
                  '‹ العودة إلى لوحة القسم',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'نموذج تجريبي · بيانات افتراضية',
                  style: TextStyle(
                    color: AppColors.hint,
                    fontSize: 12,
                  ),
                ),
              ),
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
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.navy,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: AppColors.navy,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(color: AppColors.hint),
        ),
      ],
    );
  }

  Widget _statusChip(String status) {
    final isPending = status == 'بانتظار الموافقة';
    final isInProgress = status == 'قيد العمل';
    final background = isPending
        ? const Color(0xFFF8F0E2)
        : isInProgress
            ? AppColors.primaryLight
            : const Color(0xFFEAF3EE);
    final foreground = isPending
        ? AppColors.warning
        : isInProgress
            ? AppColors.primary
            : AppColors.success;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _actionButton(
    BuildContext context,
    String title, {
    required VoidCallback onPressed,
    bool filled = false,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: filled ? AppColors.primary : Colors.transparent,
        foregroundColor: filled ? Colors.white : AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
