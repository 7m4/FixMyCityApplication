import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/admin_models.dart';
import '../widgets/admin_widgets.dart';

class ReportsMapScreen extends StatefulWidget {
  final List<CityReport> reports;
  final List<Department> departments;
  final ValueChanged<CityReport> onReportTap;
  const ReportsMapScreen({super.key, required this.reports, required this.departments, required this.onReportTap});
  @override
  State<ReportsMapScreen> createState() => _ReportsMapScreenState();
}

class _ReportsMapScreenState extends State<ReportsMapScreen> {
  String _department = 'كل الأقسام';
  String _status = 'جميع الحالات';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.reports.where((r) =>
      (_department == 'كل الأقسام' || r.department == _department) &&
      (_status == 'جميع الحالات' || r.status == _status)).toList();

    return Column(children: [
      const AdminHeader(),
      const AdminPageHeader('خريطة البلاغات العامة', 'استعرض البلاغات حسب القسم والموقع'),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [
        Expanded(child: DropdownButtonFormField<String>(
          value: _department, isExpanded: true, decoration: const InputDecoration(filled: true, fillColor: Colors.white),
          items: ['كل الأقسام', ...widget.departments.map((d) => d.name)].map((v) => DropdownMenuItem(value: v, child: Text(v, overflow: TextOverflow.ellipsis))).toList(),
          onChanged: (v) => setState(() => _department = v ?? 'كل الأقسام'),
        )),
        const SizedBox(width: 8),
        Expanded(child: DropdownButtonFormField<String>(
          value: _status, isExpanded: true, decoration: const InputDecoration(filled: true, fillColor: Colors.white),
          items: ['جميع الحالات', 'بانتظار الموافقة', 'قيد التنفيذ', 'تم الحل'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: (v) => setState(() => _status = v ?? 'جميع الحالات'),
        )),
      ])),
      const SizedBox(height: 14),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(height: 260, child: CustomPaint(
          painter: _AdminMapPainter(),
          child: Stack(children: [
            const Positioned(top: 14, right: 18, child: Text('الزرقاء', style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 18))),
            ...List.generate(filtered.length, (i) {
              const positions = [Offset(.22, .28), Offset(.72, .25), Offset(.49, .60), Offset(.82, .72), Offset(.24, .76)];
              final p = positions[i % positions.length];
              return Positioned(left: MediaQuery.of(context).size.width * p.dx * .82, top: 260 * p.dy,
                child: GestureDetector(onTap: () => widget.onReportTap(filtered[i]), child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                  child: const Icon(Icons.location_on, color: Colors.white, size: 18),
                )),
              );
            }),
          ]),
        )),
      )),
      Padding(padding: const EdgeInsets.all(14), child: Align(alignment: Alignment.centerRight, child: Text('عرض ${filtered.length} موقعاً', style: const TextStyle(color: AppColors.text)))),
      Expanded(child: filtered.isEmpty ? const Center(child: Text('لا توجد بلاغات تطابق عوامل التصفية')) : ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
        itemCount: filtered.length,
        itemBuilder: (_, i) {
          final r = filtered[i];
          return Card(color: Colors.white, elevation: 0, child: ListTile(
            leading: const CircleAvatar(backgroundColor: AppColors.primaryLight, child: Icon(Icons.report_problem, color: AppColors.primary)),
            title: Text(r.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${r.id}\n${r.department} · ${r.location}\n${r.date}'),
            isThreeLine: true, trailing: const Icon(Icons.chevron_left),
            onTap: () => widget.onReportTap(r),
          ));
        },
      )),
    ]);
  }
}

class _AdminMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final blocks = Paint()..color = const Color(0xFFC8DED2);
    final roads = Paint()..color = Colors.white..strokeWidth = 20..style = PaintingStyle.stroke;
    final details = Paint()..color = const Color(0xFFC8D9D2)..strokeWidth = 2..style = PaintingStyle.stroke;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 2; j++) {
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(12 + i * size.width / 3, 16 + j * size.height / 2.3, size.width / 3 - 25, size.height / 2.6), const Radius.circular(14)), blocks);
      }
    }
    final p1 = Path()..moveTo(0, size.height * .42)..lineTo(size.width, size.height * .48);
    final p2 = Path()..moveTo(size.width * .34, 0)..lineTo(size.width * .44, size.height);
    final p3 = Path()..moveTo(size.width * .72, 0)..lineTo(size.width * .65, size.height);
    canvas.drawPath(p1, roads); canvas.drawPath(p2, roads); canvas.drawPath(p3, roads); canvas.drawPath(p1, details);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
