import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Navigation container for the employee portal.
/// Each tab will be connected to its Figma screen in the following phases.
class EmployeeShell extends StatefulWidget {
  const EmployeeShell({super.key});

  @override
  State<EmployeeShell> createState() => _EmployeeShellState();
}

class _EmployeeShellState extends State<EmployeeShell> {
  int _tab = 0;

  static const _tabs = [
    _EmployeeTabPlaceholder(
      title: 'الرئيسية',
      message: 'سيتم تنفيذ لوحة تحكم مدير القسم في المرحلة التالية.',
      icon: Icons.home_outlined,
    ),
    _EmployeeTabPlaceholder(
      title: 'الخريطة',
      message: 'ستظهر خريطة بلاغات القسم هنا.',
      icon: Icons.map_outlined,
    ),
    _EmployeeTabPlaceholder(
      title: 'المكررة',
      message: 'ستظهر البلاغات المتكررة هنا.',
      icon: Icons.copy_outlined,
    ),
    _EmployeeTabPlaceholder(
      title: 'حسابي',
      message: 'ستظهر معلومات حساب الموظف هنا.',
      icon: Icons.person_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: IndexedStack(
            index: _tab,
            children: _tabs,
          ),
        ),
        bottomNavigationBar: NavigationBar(
          height: 68,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primaryLight,
          selectedIndex: _tab,
          onDestinationSelected: (index) => setState(() => _tab = index),
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
