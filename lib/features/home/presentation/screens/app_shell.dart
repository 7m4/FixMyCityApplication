import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_bottom_navigation.dart';
import '../../../create_report/presentation/screens/create_report_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../reports/presentation/screens/reports_screen.dart';
import 'home_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}
class _AppShellState extends State<AppShell> {
  AppTab _selectedTab = AppTab.home;

  void _selectTab(AppTab tab) => setState(() => _selectedTab = tab);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onOpenReports: () => _selectTab(AppTab.reports)),
      const ReportsScreen(),
      const NotificationsScreen(),
      const _ProfileScreen(),
    ];
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      body: IndexedStack(index: AppTab.values.indexOf(_selectedTab), children: pages),
      floatingActionButton: _selectedTab == AppTab.home || _selectedTab == AppTab.reports
          ? FloatingActionButton.extended(
              onPressed: _createReport,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('بلاغ جديد'),
            )
          : null,
      bottomNavigationBar: AppBottomNavigation(selectedTab: _selectedTab, onSelected: _selectTab),
    ));
  }

  void _createReport() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateReportScreen()));
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('حسابي')),
    body: ListView(padding: const EdgeInsets.all(20), children: const [
      CircleAvatar(radius: 42, backgroundColor: AppColors.primaryLight, child: Icon(Icons.person, color: AppColors.primary, size: 42)),
      SizedBox(height: 16),
      Center(child: Text('أحمد محمد', style: TextStyle(color: AppColors.navy, fontSize: 20, fontWeight: FontWeight.bold))),
      SizedBox(height: 5),
      Center(child: Text('حساب تجريبي', style: TextStyle(color: AppColors.text))),
      SizedBox(height: 24),
      ListTile(leading: Icon(Icons.badge_outlined), title: Text('رقم الهوية'), subtitle: Text('1234567890')),
      ListTile(leading: Icon(Icons.phone_outlined), title: Text('رقم الهاتف'), subtitle: Text('079 000 0000')),
      ListTile(leading: Icon(Icons.info_outline), title: Text('عن التطبيق'), subtitle: Text('نسخة تجريبية محلية من FixMyCity')),
    ]),
  );
}