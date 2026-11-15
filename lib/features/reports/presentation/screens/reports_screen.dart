import 'package:flutter/material.dart';
import '../../../../core/testing/test_data_loader.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../widgets/report_card.dart';
import 'report_details_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}
class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedStatus = 'الكل';
  String _selectedDepartment = 'كل الجهات';
  final List<String> _statuses = const ['الكل', 'قيد المراجعة', 'قيد التنفيذ', 'تم الحل', 'مرفوض'];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('بلاغاتي')),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: TestDataLoader.loadList('large_reports.json'),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Center(child: Text('تعذّر تحميل البلاغات.'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        final departments = snapshot.data!.map((r) => r['department'].toString()).toSet().toList();
        final reports = snapshot.data!.where((report) {
          final statusMatches = _selectedStatus == 'الكل' || report['status'] == _selectedStatus;
          final departmentMatches = _selectedDepartment == 'كل الجهات' || report['department'] == _selectedDepartment;
          return statusMatches && departmentMatches;
        }).toList();
        return Column(children: [
          SizedBox(
            height: 54,
            child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), children: _statuses.map((status) {
              final selected = _selectedStatus == status;
              return Padding(
                padding: const EdgeInsets.only(left: 6),
                child: ChoiceChip(label: Text(status), selected: selected, onSelected: (_) => setState(() => _selectedStatus = status), selectedColor: AppColors.primaryLight),
              );
            }).toList()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: DropdownButtonFormField<String>(
              value: _selectedDepartment,
              decoration: const InputDecoration(labelText: 'الجهة المسؤولة'),
              items: ['كل الجهات', ...departments].map((value) => DropdownMenuItem(value: value, child: Text(value, overflow: TextOverflow.ellipsis))).toList(),
              onChanged: (value) => setState(() => _selectedDepartment = value ?? 'كل الجهات'),
            ),
          ),
          Expanded(child: reports.isEmpty
            ? const Center(child: AppCard(child: Text('لا توجد بلاغات تطابق عوامل التصفية.')))
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 90),
                itemCount: reports.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => ReportCard(
                  report: reports[index],
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportDetailsScreen(report: reports[index]))),
                ),
              )),
        ]);
      },
    ),
  );
}