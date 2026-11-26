import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'manager_dashboard_screen.dart';

class UpdateReportStatusScreen extends StatefulWidget {
  const UpdateReportStatusScreen({
    super.key,
    required this.report,
    required this.onSave,
    required this.onCancel,
  });

  final SampleReport report;
  final ValueChanged<String> onSave;
  final VoidCallback onCancel;

  @override
  State<UpdateReportStatusScreen> createState() =>
      _UpdateReportStatusScreenState();
}

class _UpdateReportStatusScreenState extends State<UpdateReportStatusScreen> {
  static const _statuses = [
    'قيد العمل',
    'تم الحل',
    'مرفوض',
  ];

  late String _selectedStatus;
  final _notesController = TextEditingController(
    text: 'تمت مراجعة البلاغ والتحقق من الموقع والمرفقات.',
  );
  final _rejectionController = TextEditingController(
    text: 'الموقع المحدد خارج نطاق اختصاص القسم.',
  );

  bool _showRejectionError = false;

  bool get _requiresRejectionReason => _selectedStatus == 'مرفوض';

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.report.status == 'بانتظار الموافقة'
        ? 'مرفوض'
        : widget.report.status;
    if (!_statuses.contains(_selectedStatus)) {
      _selectedStatus = _statuses.first;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    _rejectionController.dispose();
    super.dispose();
  }

  void _save() {
    if (_requiresRejectionReason && _rejectionController.text.trim().isEmpty) {
      setState(() => _showRejectionError = true);
      return;
    }
    widget.onSave(_selectedStatus);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'تعديل حالة البلاغ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'حدّث حالة البلاغ وأضف ملاحظات المعالجة',
                textAlign: TextAlign.right,
                style: TextStyle(color: AppColors.text, fontSize: 13),
              ),
              const SizedBox(height: 20),
              _reportCard(),
              const SizedBox(height: 20),
              _fieldLabel('الحالة الجديدة'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                isExpanded: true,
                decoration: _inputDecoration(),
                items: _statuses
                    .map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedStatus = value;
                    _showRejectionError = false;
                  });
                },
              ),
              const SizedBox(height: 7),
              const Text(
                'اختر الحالة المناسبة لسير معالجة البلاغ.',
                textAlign: TextAlign.right,
                style: TextStyle(color: AppColors.hint, fontSize: 12),
              ),
              const SizedBox(height: 20),
              _fieldLabel('ملاحظات المعالجة'),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                minLines: 3,
                maxLines: 4,
                textAlign: TextAlign.right,
                decoration: _inputDecoration(
                  hint: 'أضف ملاحظات حول معالجة البلاغ...',
                ),
              ),
              if (_requiresRejectionReason) ...[
                const SizedBox(height: 20),
                _fieldLabel('سبب الرفض *', color: AppColors.error),
                const SizedBox(height: 8),
                TextField(
                  controller: _rejectionController,
                  minLines: 2,
                  maxLines: 3,
                  textAlign: TextAlign.right,
                  onChanged: (_) {
                    if (_showRejectionError) {
                      setState(() => _showRejectionError = false);
                    }
                  },
                  decoration: _inputDecoration(
                    hint: 'اكتب سبب رفض البلاغ...',
                    error: _showRejectionError,
                  ),
                ),
                if (_showRejectionError)
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      'يرجى إدخال سبب الرفض قبل الحفظ.',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: AppColors.error, fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 8),
                _notice(
                  'سبب الرفض إلزامي عند اختيار «مرفوض».',
                  icon: Icons.info_outline,
                  color: AppColors.error,
                ),
              ],
              const SizedBox(height: 14),
              _notice(
                'سيُرسل إشعار للمواطن عند حفظ التحديث.',
                icon: Icons.notifications_active_outlined,
                color: AppColors.primary,
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 50,
                child: FilledButton(
                  onPressed: _save,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'حفظ تحديث الحالة',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('إلغاء'),
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _reportCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.report.title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.report.id,
            textDirection: TextDirection.ltr,
            style: const TextStyle(color: AppColors.hint, fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'الحالة الحالية: ',
                style: TextStyle(color: AppColors.text, fontSize: 12),
              ),
              _statusChip(widget.report.status),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String label, {Color color = AppColors.navy}) {
    return Text(
      label,
      textAlign: TextAlign.right,
      style: TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  InputDecoration _inputDecoration({
    String? hint,
    bool error = false,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.hint, fontSize: 13),
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: error ? AppColors.error : AppColors.border,
          width: error ? 1.4 : 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }

  Widget _notice(
    String message, {
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 19),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.right,
              style: TextStyle(color: color, fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final isRejected = status == 'مرفوض';
    final isPending = status == 'بانتظار الموافقة';
    final color = isRejected
        ? AppColors.error
        : isPending
            ? AppColors.warning
            : status == 'تم الحل'
                ? AppColors.success
                : AppColors.primary;
    final background = isRejected
        ? const Color(0xFFFCEDEC)
        : isPending
            ? const Color(0xFFF8F0E2)
            : status == 'تم الحل'
                ? const Color(0xFFEAF3EE)
                : AppColors.primaryLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
