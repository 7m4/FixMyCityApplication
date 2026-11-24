import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/admin_models.dart';

class DepartmentFormScreen extends StatefulWidget {
  final Department? existing;
  final List<ReportType> allTypes;
  const DepartmentFormScreen({super.key, this.existing, required this.allTypes});
  @override
  State<DepartmentFormScreen> createState() => _DepartmentFormScreenState();
}

class _DepartmentFormScreenState extends State<DepartmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;
  late String _institution;
  late String _manager;
  late List<String> _selectedTypes;

  @override
  void initState() {
    super.initState();
    final d = widget.existing;
    _name = TextEditingController(text: d?.name ?? '');
    _description = TextEditingController(text: d?.description ?? '');
    _institution = d?.institution ?? 'بلدية الزرقاء';
    _manager = d?.manager ?? 'سارة الخطيب';
    _selectedTypes = List<String>.from(d?.types ?? []);
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: Text(widget.existing == null ? 'إضافة قسم جديد' : 'تعديل القسم')),
      body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(18), children: [
        Text(widget.existing == null ? 'أضف قسماً وحدد نطاق عمله ومسؤوله' : 'حدّث بيانات القسم ومسؤوله وأنواع البلاغات', style: const TextStyle(color: AppColors.text)),
        const SizedBox(height: 18),
        TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'اسم القسم'), validator: _required),
        const SizedBox(height: 14),
        TextFormField(controller: _description, maxLines: 3, decoration: const InputDecoration(labelText: 'وصف القسم'), validator: _required),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(value: _institution, decoration: const InputDecoration(labelText: 'موقع المؤسسة'), items: ['بلدية الزرقاء', 'مؤسسة خدمات المياه'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => _institution = v ?? _institution)),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(value: _manager, decoration: const InputDecoration(labelText: 'حساب المواطن المسؤول عن القسم'), items: ['سارة الخطيب', 'أحمد العلي', 'ريم حسن', 'عمر محمود', 'ليلى خالد'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) => setState(() => _manager = v ?? _manager)),
        const SizedBox(height: 18),
        const Text('أنواع البلاغات التابعة للقسم', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(spacing: 6, children: widget.allTypes.map((t) => FilterChip(label: Text(t.name), selected: _selectedTypes.contains(t.name), onSelected: (selected) => setState(() { selected ? _selectedTypes.add(t.name) : _selectedTypes.remove(t.name); }))).toList()),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: FilledButton(onPressed: _save, child: Text(widget.existing == null ? 'إضافة القسم' : 'حفظ التعديلات'))),
      ])),
    ),
  );

  String? _required(String? value) => value == null || value.trim().isEmpty ? 'هذا الحقل مطلوب' : null;

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, Department(
      name: _name.text.trim(), description: _description.text.trim(),
      institution: _institution, manager: _manager, types: _selectedTypes,
      reports: widget.existing?.reports ?? 0, solved: widget.existing?.solved ?? 0,
      active: widget.existing?.active ?? true,
    ));
  }
}
