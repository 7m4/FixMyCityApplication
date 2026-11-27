import 'package:flutter/material.dart';
import '../../data/employee_reports_data.dart';
import '../../../../core/theme/app_colors.dart';
import 'manager_dashboard_screen.dart';
import 'department_reports_map_screen.dart';
import 'report_details_screen.dart';
import 'transfer_report_screen.dart';
import 'update_report_status_screen.dart';
import 'duplicate_reports_screen.dart';

class EmployeeShell extends StatefulWidget {
  const EmployeeShell({super.key});

  @override
  State<EmployeeShell> createState() => _EmployeeShellState();
}

class _EmployeeShellState extends State<EmployeeShell> {
  int _tab = 0;
  SampleReport? _selectedReport;
  bool _isUpdatingStatus = false;
  bool _isTransferringReport = false;
  bool _isReviewingDuplicates = false;

  final List<SampleReport> _reports = EmployeeReportsData.reports;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ManagerDashboardScreen(
        reports: _reports,
        onReportTap: (report) {
          setState(() {
            _selectedReport = report;
            _isUpdatingStatus = false;
            _isTransferringReport = false;
          });
        },
      ),
      DepartmentReportsMapScreen(
        reports: _reports,
        onReportTap: (report) {
          setState(() {
            _selectedReport = report;
            _isUpdatingStatus = false;
            _isTransferringReport = false;
          });
        },
      ),
      DuplicateReportsScreen(
        reports: _reports,
        onReviewReport: (report) {
          setState(() {
            _selectedReport = report;
            _isUpdatingStatus = false;
            _isTransferringReport = false;
            _isReviewingDuplicates = false;
          });
        },
      ),
      const _EmployeeTabPlaceholder(
        title: 'حسابي',
        message: 'ستظهر معلومات حساب الموظف هنا.',
        icon: Icons.person_outline,
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ColoredBox(
        color: AppColors.background,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 393),
            child: SizedBox(
              width: double.infinity,
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: SafeArea(
                  child: _selectedReport != null
                      ? _isReviewingDuplicates
                          ? DuplicateReportsScreen(
                              reports: _reports,
                              primaryReportId: _selectedReport!.id,
                              onBack: () {
                                setState(() => _isReviewingDuplicates = false);
                              },
                              onReviewReport: (report) {
                                setState(() {
                                  _selectedReport = report;
                                  _isReviewingDuplicates = false;
                                });
                              },
                            )
                          : _isUpdatingStatus
                              ? UpdateReportStatusScreen(
                              report: _selectedReport!,
                              onSave: (newStatus, notes, rejectionReason) {
                                setState(() {
                                  _selectedReport!.status = newStatus;
                                  _selectedReport!.lastUpdated = 'تم التحديث الآن';
                                  _selectedReport!.actionHistory.add(
                                    'تم تحديث الحالة إلى: $newStatus',
                                  );
                                  if (notes.isNotEmpty) {
                                    _selectedReport!.actionHistory.add(
                                      'ملاحظات المعالجة: $notes',
                                    );
                                  }
                                  if (rejectionReason.isNotEmpty) {
                                    _selectedReport!.actionHistory.add(
                                      'سبب الرفض: $rejectionReason',
                                    );
                                  }
                                  _isUpdatingStatus = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تم تحديث حالة البلاغ بنجاح.'),
                                  ),
                                );
                              },
                              onCancel: () {
                                setState(() => _isUpdatingStatus = false);
                              },
                            )
                          : _isTransferringReport
                              ? TransferReportScreen(
                                  report: _selectedReport!,
                                  onTransfer: (department, reason, notes) {
                                    setState(() {
                                      _selectedReport!.department = department;
                                      _selectedReport!.lastUpdated = 'تم التحويل الآن';
                                      _selectedReport!.actionHistory.add(
                                        'تم تحويل البلاغ إلى $department. السبب: $reason',
                                      );
                                      if (notes.isNotEmpty) {
                                        _selectedReport!.actionHistory.add(
                                          'ملاحظات التحويل: $notes',
                                        );
                                      }
                                      _isTransferringReport = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'تم تحويل البلاغ إلى $department بنجاح.',
                                        ),
                                      ),
                                    );
                                  },
                                  onCancel: () {
                                    setState(
                                      () => _isTransferringReport = false,
                                    );
                                  },
                                )
                              : ReportDetailsScreen(
                                  report: _selectedReport!,
                                  onBack: () {
                                    setState(() {
                                      _selectedReport = null;
                                      _isUpdatingStatus = false;
                                      _isTransferringReport = false;
                                    });
                                  },
                                  onEditStatus: () {
                                    setState(() {
                                      _isUpdatingStatus = true;
                                      _isTransferringReport = false;
                                    });
                                  },
                                  onTransferReport: () {
                                    setState(() {
                                      _isTransferringReport = true;
                                      _isUpdatingStatus = false;
                                    });
                                  },
                                  onReviewDuplicates: () {
                                    setState(() {
                                      _isReviewingDuplicates = true;
                                      _isUpdatingStatus = false;
                                      _isTransferringReport = false;
                                    });
                                  },
                                )
                      : IndexedStack(
                          index: _tab,
                          children: pages,
                        ),
                ),
                bottomNavigationBar: NavigationBar(
                  height: 68,
                  labelBehavior:
                      NavigationDestinationLabelBehavior.alwaysShow,
                  backgroundColor: AppColors.surface,
                  indicatorColor: AppColors.primaryLight,
                  selectedIndex: _tab,
                  onDestinationSelected: (index) {
                    setState(() {
                      _tab = index;
                      _selectedReport = null;
                      _isUpdatingStatus = false;
                      _isTransferringReport = false;
                      _isReviewingDuplicates = false;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'الرئيسية',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.map_outlined),
                      selectedIcon: Icon(Icons.map),
                      label: 'الخريطة',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.copy_outlined),
                      selectedIcon: Icon(Icons.copy),
                      label: 'المكررة',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'حسابي',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmployeeTabPlaceholder extends StatelessWidget {
  const _EmployeeTabPlaceholder({
    required this.title,
    required this.message,
    required this.icon,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.text),
            ),
          ],
        ),
      ),
    );
  }
}
