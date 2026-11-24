import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/admin_models.dart';

class ReportTypeFormScreen extends StatefulWidget {
  final Set<String> existingCodes;
  const ReportTypeFormScreen({super.key, required this.existingCodes});
  @override
  State<ReportTypeFormScreen> createState() => _ReportTypeFormScreenState();
}

class _ReportTypeFormScreenState extends State<ReportTypeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _code = TextEditingController();
  final _description = TextEditingController();

  @override
  void dispose() {
    _name.dispose(); _code.dispose(); _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('إضافة نوع بلاغ')),
      body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(18), children: [
        const Text('أدخل بيانات نوع البلاغ الجديد', style: TextStyle(color: AppColors.text)),
        const SizedBox(height: 18),
        TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'اسم نوع البلاغ'), validator: _required, onChanged: (_) => setState(() {})),
        const SizedBox(height: 14),
        TextFormField(controller: _code, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'الرمز التعريفي', hintText: 'ROAD-POTHOLE'), validator: _required),
        const SizedBox(height: 14),
        TextFormField(controller: _description, maxLines: 3, decoration: const InputDecoration(labelText: 'الوصف'), validator: _required, onChanged: (_) => setState(() {})),
        const SizedBox(height: 18),
        Card(color: Colors.white, child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('معاينة', style: TextStyle(color: AppColors.text)),
          const SizedBox(height: 8),
          Text(_name.text.isEmpty ? 'اسم المشكلة' : _name.text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.navy)),
          Text(_description.text.isEmpty ? 'سيظهر وصف المشكلة هنا.' : _description.text),
        ]))),
        const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: FilledButton(onPressed: _save, child: const Text('إضافة نوع البلاغ'))),
      ])),
    ),
  );

  String? _required(String? value) => value == null || value.trim().isEmpty ? 'هذا الحقل مطلوب' : null;

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final normalized = _code.text.trim().toUpperCase();
    if (!RegExp(r'^[A-Z0-9-]+$').hasMatch(normalized)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('الرمز يجب أن يحتوي على حروف إنجليزية وأرقام وشرطة فقط')));
      return;
    }
    if (widget.existingCodes.contains(normalized)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('هذا الرمز مستخدم مسبقاً، أدخل رمزاً فريداً')));
      return;
    }
    Navigator.pop(context, ReportType(_name.text.trim(), normalized, _description.text.trim()));
  }
}
