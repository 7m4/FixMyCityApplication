import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/admin_models.dart';
import '../widgets/admin_widgets.dart';

class DepartmentsScreen extends StatefulWidget {
  final List<Department> departments;
  final VoidCallback onAdd;
  final ValueChanged<Department> onEdit;
  final ValueChanged<Department> onDelete;
  const DepartmentsScreen({super.key, required this.departments, required this.onAdd, required this.onEdit, required this.onDelete});
  @override
  State<DepartmentsScreen> createState() => _DepartmentsScreenState();
}

class _DepartmentsScreenState extends State<DepartmentsScreen> {
  String _query = '';
  @override
  Widget build(BuildContext context) {
    final filtered = widget.departments.where((d) => d.name.contains(_query) || d.manager.contains(_query) || d.institution.contains(_query)).toList();
    return Column(children: [
      const AdminHeader(),
      const AdminPageHeader('إدارة الأقسام', 'تابع الأقسام والمؤسسات المسؤولة'),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 18), child: Row(children: [
        Expanded(child: TextField(onChanged: (v) => setState(() => _query = v), decoration: const InputDecoration(hintText: 'ابحث عن قسم أو مؤسسة...', prefixIcon: Icon(Icons.search)))),
        const SizedBox(width: 8),
        FilledButton(onPressed: widget.onAdd, child: const Icon(Icons.add)),
      ])),
      const SizedBox(height: 12),
      Expanded(child: filtered.isEmpty ? const Center(child: Text('لا توجد أقسام مطابقة')) : ListView.builder(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
        itemCount: filtered.length,
        itemBuilder: (_, i) {
          final d = filtered[i];
          return Card(color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: AppColors.border)),
            child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(d.name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: AppColors.navy))),
                Chip(label: Text(d.active ? 'نشط' : 'غير نشط'), backgroundColor: AppColors.primaryLight, side: BorderSide.none),
              ]),
              Text('${d.institution} · ${d.manager}', style: const TextStyle(color: AppColors.text)),
              const SizedBox(height: 8),
              Text('${d.reports} بلاغاً · ${d.types.length} أنواع بلاغات'),
              const Divider(height: 22),
              Row(children: [
                Expanded(child: OutlinedButton.icon(onPressed: () => widget.onDelete(d), icon: const Icon(Icons.delete_outline, color: AppColors.error), label: const Text('حذف القسم'))),
                const SizedBox(width: 10),
                Expanded(child: FilledButton.tonalIcon(onPressed: () => widget.onEdit(d), icon: const Icon(Icons.edit), label: const Text('تعديل القسم'))),
              ]),
            ])),
          );
        },
      )),
    ]);
  }
}
