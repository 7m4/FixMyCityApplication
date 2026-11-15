import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum AppTab { home, reports, notifications, profile }

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({required this.selectedTab, required this.onSelected, super.key});

  final AppTab selectedTab;
  final ValueChanged<AppTab> onSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      indicatorColor: AppColors.primaryLight,
      selectedIndex: AppTab.values.indexOf(selectedTab),
      onDestinationSelected: (index) => onSelected(AppTab.values[index]),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
        NavigationDestination(icon: Icon(Icons.folder_outlined), selectedIcon: Icon(Icons.folder), label: 'بلاغاتي'),
        NavigationDestination(icon: Icon(Icons.notifications_none), selectedIcon: Icon(Icons.notifications), label: 'الإشعارات'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
      ],
    );
  }
}