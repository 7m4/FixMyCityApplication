import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/admin_models.dart';
import '../widgets/admin_widgets.dart';

class DashboardScreen extends StatelessWidget {
  final int total;
  final int solved;
  final List<Department> departments;
  final VoidCallback onAddDepartment;
  final VoidCallback onAddType;
  final VoidCallback onOpenMap;
  final VoidCallback onOpenDepartments;

  const DashboardScreen({
    super.key, required this.total, required this.solved, required this.departments,
    required this.onAddDepartment, required this.onAddType, required this.onOpenMap,
    required this.onOpenDepartments,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : solved / total;
    return CustomScrollView(slivers: [
      const SliverToBoxAdapter(child: AdminHeader()),
      const SliverToBoxAdapter(child: AdminPageHeader('لوحة المسؤول العام', 'نظرة شاملة على البلاغات والأقسام')),
      SliverToBoxAdapter(child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(22)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('إجمالي البلاغات', style: TextStyle(color: Colors.white, fontSize: 16)),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('$total', style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900)),
            const Spacer(),
            Text('$solved بلاغاً تم حله', style: const TextStyle(color: Colors.white70)),
          ]),
          const SizedBox(height: 15),
          ClipRRect(borderRadius: BorderRadius.circular(20), child: LinearProgressIndicator(value: progress, minHeight: 9, backgroundColor: Colors.white30, color: const Color(0xFFB8E3D2))),
          const SizedBox(height: 7),
          Text('نسبة الإنجاز ${(progress * 100).toStringAsFixed(1)}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ]),
      )),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
        Expanded(child: OutlinedButton.icon(onPressed: onAddType, icon: const Icon(Icons.add), label: const Text('إضافة نوع بلاغ'))),
        const SizedBox(width: 10),
        Expanded(child: FilledButton.icon(onPressed: onAddDepartment, icon: const Icon(Icons.add), label: const Text('إضافة قسم'))),
      ]))),
      SliverToBoxAdapter(child: AdminSectionCard(title: 'الأقسام والمؤسسات', child: Column(children: departments.map((d) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(children: [
          Expanded(child: Text(d.name, style: const TextStyle(fontWeight: FontWeight.w600))),
          Text('${d.reports}', style: const TextStyle(color: AppColors.navy)),
          const SizedBox(width: 22),
          Text('${d.solved}', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
        ]),
      )).toList()))),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(18, 0, 18, 24), child: Column(children: [
        SizedBox(width: double.infinity, child: TextButton.icon(onPressed: onOpenMap, icon: const Icon(Icons.map_outlined), label: const Text('استعراض خريطة جميع البلاغات'))),
        SizedBox(width: double.infinity, child: TextButton.icon(onPressed: onOpenDepartments, icon: const Icon(Icons.apartment), label: const Text('إدارة الأقسام'))),
      ]))),
    ]);
  }
}
