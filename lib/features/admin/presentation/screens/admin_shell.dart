import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/admin_models.dart';
import '../widgets/admin_widgets.dart';
import 'admin_account_screen.dart';
import 'dashboard_screen.dart';
import 'departments_screen.dart';
import 'reports_map_screen.dart';
import 'department_form_screen.dart';
import 'report_type_form_screen.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});
  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _tab = 0;
  late final List<Department> _departments = sampleDepartments();
  late final List<ReportType> _types = sampleReportTypes();
  late final List<CityReport> _reports = sampleCityReports();

  int get _total => _departments.fold(0, (sum, item) => sum + item.reports);
  int get _solved => _departments.fold(0, (sum, item) => sum + item.solved);

  Future<void> _openDepartmentForm({Department? existing}) async {
    final result = await Navigator.push<Department>(context, MaterialPageRoute(
      builder: (_) => DepartmentFormScreen(existing: existing, allTypes: _types),
    ));
    if (result == null || !mounted) return;
    setState(() {
      if (existing == null) {
        _departments.add(result);
      } else {
        final index = _departments.indexOf(existing);
        if (index >= 0) _departments[index] = result;
      }
    });
    _message(existing == null ? 'تمت إضافة القسم بنجاح' : 'تم حفظ تعديلات القسم');
  }

  Future<void> _openReportTypeForm() async {
    final result = await Navigator.push<ReportType>(context, MaterialPageRoute(
      builder: (_) => ReportTypeFormScreen(existingCodes: _types.map((e) => e.code).toSet()),
    ));
    if (result == null || !mounted) return;
    setState(() => _types.add(result));
    _message('تمت إضافة نوع البلاغ بنجاح');
  }

  void _message(String value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));

  void _deleteDepartment(Department department) {
    showDialog(context: context, builder: (dialogContext) => AlertDialog(
      title: const Text('حذف القسم؟'),
      content: Text('هل تريد حذف قسم «${department.name}»؟'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')),
        FilledButton(onPressed: () {
          setState(() => _departments.remove(department));
          Navigator.pop(dialogContext);
          _message('تم حذف القسم');
        }, child: const Text('حذف')),
      ],
    ));
  }

  void _showReportDetails(CityReport report) {
    showModalBottomSheet(context: context, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))), builder: (ctx) => Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(padding: const EdgeInsets.all(22), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(report.title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: AppColors.navy)),
        const SizedBox(height: 8),
        Text(report.id, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        const Divider(height: 24),
        _detailRow('القسم', report.department),
        _detailRow('الموقع', report.location),
        _detailRow('تاريخ البلاغ', report.date),
        _detailRow('الحالة', report.status),
        const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('إغلاق'))),
      ])),
    ));
  }

  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(children: [
      SizedBox(width: 105, child: Text(label, style: const TextStyle(color: AppColors.text))),
      Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
    ]),
  );

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('تسجيل الخروج'),
      content: const Text('هل تريد إنهاء الجلسة الحالية؟'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('تسجيل الخروج')),
      ],
    ));
    if (confirmed == true && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(total: _total, solved: _solved, departments: _departments,
        onAddDepartment: () => _openDepartmentForm(), onAddType: _openReportTypeForm,
        onOpenMap: () => setState(() => _tab = 1), onOpenDepartments: () => setState(() => _tab = 2)),
      ReportsMapScreen(reports: _reports, departments: _departments, onReportTap: _showReportDetails),
      DepartmentsScreen(departments: _departments, onAdd: () => _openDepartmentForm(),
        onEdit: (d) => _openDepartmentForm(existing: d), onDelete: _deleteDepartment),
      AdminAccountScreen(onLogout: _logout),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(top: false, child: IndexedStack(index: _tab, children: pages)),
        bottomNavigationBar: NavigationBar(
          height: 68,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: Colors.white,
          indicatorColor: AppColors.primaryLight,
          selectedIndex: _tab,
          onDestinationSelected: (index) => setState(() => _tab = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'الخريطة'),
            NavigationDestination(icon: Icon(Icons.account_balance_outlined), selectedIcon: Icon(Icons.account_balance), label: 'الأقسام'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      ),
    );
  }
}
