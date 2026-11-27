import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/employee_reports_data.dart';

class TransferReportScreen extends StatefulWidget {
  const TransferReportScreen({
    super.key,
    required this.report,
    required this.onTransfer,
    required this.onCancel,
  });

  final SampleReport report;
  final void Function(String department, String reason, String notes) onTransfer;
  final VoidCallback onCancel;

  @override
  State<TransferReportScreen> createState() => _TransferReportScreenState();
}

class _TransferReportScreenState extends State<TransferReportScreen> {
  static const _departments = [
    'إدارة صيانة الطرق',
    'إدارة الأرصفة',
    'قسم الإنارة',
    'قسم النظافة',
  ];

  late String _selectedDepartment;
  final _reasonController = TextEditingController(
    text: 'يتطلب البلاغ تدخل فريق صيانة الطرق لمعاينة الحفرة وإصلاح طبقة الإسفلت.',
  );
  final _notesController = TextEditingController(
    text: 'يرجى إعطاء الأولوية للموقع لقربه من دوار الجيش.',
  );
  bool _showReasonError = false;

  @override
  void initState() {
    super.initState();
    _selectedDepartment = _departments.first;
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _confirmTransfer() {
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      setState(() => _showReasonError = true);
      return;
    }

    widget.onTransfer(
      _selectedDepartment,
      reason,
      _notesController.text.trim(),
    );
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
                'تحويل البلاغ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'وجّه البلاغ إلى القسم الأنسب لمعالجته',
                textAlign: TextAlign.right,
                style: TextStyle(color: AppColors.text, fontSize: 13),
              ),
              const SizedBox(height: 20),
              _reportCard(),
              const SizedBox(height: 20),
              _fieldLabel('القسم المستلم *'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedDepartment,
                isExpanded: true,
                decoration: _inputDecoration(),
                items: _departments
                    .map(
                      (department) => DropdownMenuItem(
                        value: department,
                        child: Text(department),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedDepartment = value);
                  }
                },
              ),
              const SizedBox(height: 7),
              const Text(
                'معالجة الحفر وأضرار الطرق والأرصفة',
                textAlign: TextAlign.right,
                style: TextStyle(color: AppColors.hint, fontSize: 12),
              ),
              const SizedBox(height: 20),
              _fieldLabel('سبب التحويل *'),
              const SizedBox(height: 8),
              TextField(
                controller: _reasonController,
                minLines: 3,
                maxLines: 4,
                textAlign: TextAlign.right,
                onChanged: (_) {
                  if (_showReasonError) {
                    setState(() => _showReasonError = false);
                  }
                },
                decoration: _inputDecoration(
                  hint: 'اكتب سبب تحويل البلاغ...',
                  error: _showReasonError,
                ),
              ),
              if (_showReasonError)
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    'يرجى إدخال سبب التحويل قبل المتابعة.',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: AppColors.error, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 20),
              _fieldLabel('ملاحظات إضافية (اختياري)'),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                minLines: 2,
                maxLines: 3,
                textAlign: TextAlign.right,
                decoration: _inputDecoration(
                  hint: 'أضف أي ملاحظات للقسم المستلم...',
                ),
              ),
              const SizedBox(height: 16),
              _notice(
                'سينتقل البلاغ إلى قائمة القسم المستلم، مع الاحتفاظ بسجل الإجراءات السابقة.',
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 50,
                child: FilledButton(
                  onPressed: _confirmTransfer,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'تأكيد تحويل البلاغ',
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
                    side: const BorderSide(color: AppColors.primary),
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
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.report.department,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'القسم الحالي',
                style: TextStyle(color: AppColors.hint, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: AppColors.navy,
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

  Widget _notice(String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.22),
        ),
      ),
      child: Text(
        message,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }
}
