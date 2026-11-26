import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/employee_reports_data.dart';

class DepartmentReportsMapScreen extends StatefulWidget {
  const DepartmentReportsMapScreen({
    super.key,
    required this.reports,
    required this.onReportTap,
  });

  final List<SampleReport> reports;
  final ValueChanged<SampleReport> onReportTap;

  @override
  State<DepartmentReportsMapScreen> createState() =>
      _DepartmentReportsMapScreenState();
}

class _DepartmentReportsMapScreenState
    extends State<DepartmentReportsMapScreen> {
  String _statusFilter = 'جميع الحالات';
  String _areaFilter = 'كل المناطق';
  String? _selectedReportId;
  double _zoom = 1;

  List<SampleReport> get _visibleReports => widget.reports.where((report) {
        final statusMatches = _statusFilter == 'جميع الحالات' ||
            report.status == _statusFilter;
        final areaMatches =
            _areaFilter == 'كل المناطق' || report.area == _areaFilter;
        return statusMatches && areaMatches;
      }).toList();

  SampleReport get _selectedReport {
    if (widget.reports.isEmpty) {
      throw StateError('لا توجد بلاغات لعرضها على الخريطة');
    }
    return widget.reports.firstWhere(
      (report) => report.id == _selectedReportId,
      orElse: () => widget.reports.first,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.reports.isNotEmpty) {
      _selectedReportId = widget.reports.first.id;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'تم الحل':
        return AppColors.success;
      case 'بانتظار الموافقة':
        return AppColors.warning;
      case 'مرفوض':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleReports;
    final completed = widget.reports.where((r) => r.status == 'تم الحل').length;
    final inProgress = widget.reports.where((r) => r.status == 'قيد العمل').length;
    final pending = widget.reports.where((r) => r.status == 'بانتظار الموافقة').length;
    final rejected = widget.reports.where((r) => r.status == 'مرفوض').length;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildHeader(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'خريطة بلاغات القسم',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'استعرض مواقع البلاغات حسب الحالة',
                textAlign: TextAlign.right,
                style: TextStyle(color: AppColors.text, fontSize: 13),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _filterDropdown(
                      value: _statusFilter,
                      options: const [
                        'جميع الحالات',
                        'بانتظار الموافقة',
                        'قيد العمل',
                        'تم الحل',
                        'مرفوض',
                      ],
                      onChanged: (value) => setState(() {
                        _statusFilter = value!;
                        if (!_visibleReports.any((r) => r.id == _selectedReportId)) {
                          _selectedReportId = _visibleReports.isEmpty
                              ? null
                              : _visibleReports.first.id;
                        }
                      }),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: _filterDropdown(
                      value: _areaFilter,
                      options: const [
                        'كل المناطق',
                        'شارع الملك عبدالله',
                        'منطقة الوسط',
                        'شارع الجيش',
                        'حي الزهور',
                      ],
                      onChanged: (value) => setState(() {
                        _areaFilter = value!;
                        if (!_visibleReports.any((r) => r.id == _selectedReportId)) {
                          _selectedReportId = _visibleReports.isEmpty
                              ? null
                              : _visibleReports.first.id;
                        }
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildMap(visible),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _summaryPill(completed, 'منتهية', AppColors.success)),
                  const SizedBox(width: 6),
                  Expanded(child: _summaryPill(inProgress, 'قيد العمل', AppColors.primary)),
                  const SizedBox(width: 6),
                  Expanded(child: _summaryPill(pending, 'بانتظار الموافقة', AppColors.warning)),
                  const SizedBox(width: 6),
                  Expanded(child: _summaryPill(rejected, 'مرفوض', AppColors.error)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'خريطة توضيحية · الزرقاء · ${visible.length} بلاغاً',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.hint, fontSize: 11),
              ),
              const SizedBox(height: 14),
              visible.isEmpty ? _emptyFilteredState() : _buildSelectedReport(),
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
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown({
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 19),
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          items: options
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildMap(List<SampleReport> visible) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 310,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned.fill(
                  child: Transform.scale(
                    scale: _zoom,
                    child: const CustomPaint(painter: _IllustratedMapPainter()),
                  ),
                ),
                const Positioned(
                  top: 82,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'شارع الملك عبدالله',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                ...visible.map((report) {
                  final selected = _selectedReportId == report.id;
                  return Positioned(
                    left: report.mapX * constraints.maxWidth - (selected ? 14 : 11),
                    top: report.mapY * constraints.maxHeight - (selected ? 14 : 11),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedReportId = report.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        width: selected ? 28 : 22,
                        height: selected ? 28 : 22,
                        decoration: BoxDecoration(
                          color: _statusColor(report.status),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .16),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () => setState(
                            () => _zoom = (_zoom + .15).clamp(1, 1.6).toDouble(),
                          ),
                          icon: const Icon(Icons.add, color: AppColors.navy),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () => setState(
                            () => _zoom = (_zoom - .15).clamp(1, 1.6).toDouble(),
                          ),
                          icon: const Icon(Icons.remove, color: AppColors.navy),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _summaryPill(int count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .09),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$count $label',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _emptyFilteredState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: const Text(
        'لا توجد بلاغات تطابق عوامل التصفية المحددة.',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.text, fontSize: 13),
      ),
    );
  }

  Widget _buildSelectedReport() {
    final report = _selectedReport;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            report.title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            '${report.location} · ${report.id}',
            textAlign: TextAlign.right,
            style: const TextStyle(color: AppColors.text, fontSize: 11),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _statusColor(report.status).withValues(alpha: .10),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                report.status,
                style: TextStyle(
                  color: _statusColor(report.status),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: () => widget.onReportTap(report),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'عرض تفاصيل البلاغ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _IllustratedMapPainter extends CustomPainter {
  const _IllustratedMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFE5F0EC);
    canvas.drawRect(Offset.zero & size, background);

    final blocks = Paint()..color = const Color(0xFFD2E5DC);
    final blockRects = [
      Rect.fromLTWH(size.width * .04, size.height * .08, size.width * .20, size.height * .18),
      Rect.fromLTWH(size.width * .42, size.height * .06, size.width * .16, size.height * .18),
      Rect.fromLTWH(size.width * .70, size.height * .06, size.width * .24, size.height * .18),
      Rect.fromLTWH(size.width * .06, size.height * .43, size.width * .20, size.height * .20),
      Rect.fromLTWH(size.width * .69, size.height * .42, size.width * .23, size.height * .20),
      Rect.fromLTWH(size.width * .06, size.height * .76, size.width * .22, size.height * .17),
      Rect.fromLTWH(size.width * .38, size.height * .72, size.width * .20, size.height * .20),
      Rect.fromLTWH(size.width * .73, size.height * .76, size.width * .21, size.height * .17),
    ];
    for (final rect in blockRects) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(9)),
        blocks,
      );
    }

    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 17
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final roads = [
      [Offset(-10, size.height * .33), Offset(size.width * 1.05, size.height * .39)],
      [Offset(-10, size.height * .68), Offset(size.width * 1.05, size.height * .62)],
      [Offset(size.width * .30, -10), Offset(size.width * .54, size.height * 1.05)],
      [Offset(size.width * .67, -10), Offset(size.width * .48, size.height * 1.05)],
    ];
    for (final points in roads) {
      canvas.drawLine(points[0], points[1], road);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
