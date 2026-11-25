import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../admin/presentation/screens/admin_login_screen.dart';
import '../../../employee/presentation/screens/employee_shell.dart';
import 'login_screen.dart';

class PortalScreen extends StatefulWidget {
  const PortalScreen({super.key});

  @override
  State<PortalScreen> createState() => _PortalScreenState();
}

class _PortalScreenState extends State<PortalScreen> {
  int _selectedPortal = 0;

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 18),
              const Text('اختر بوابة الدخول', style: AppTextStyles.heading),
              const SizedBox(height: 8),
              const Text('اختر البوابة المناسبة للمتابعة', style: TextStyle(color: AppColors.text)),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    _portalCard(0, Icons.person, 'بوابة المواطن', 'قدّم بلاغاتك وتابع حالتها في مدينتك.'),
                    const SizedBox(height: 12),
                    _portalCard(1, Icons.work, 'بوابة الموظف', 'تابع مهامك وقم بإدارتها داخل مؤسستك.'),
                    const SizedBox(height: 12),
                    _portalCard(2, Icons.admin_panel_settings_outlined, 'بوابة المسؤول العام', 'إدارة البلاغات والأقسام وأنواع البلاغات.'),
                  ]),
                ),
              ),
              const SizedBox(height: 14),
              AppButton(
                label: 'دخول',
                onPressed: () {
                  if (_selectedPortal == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EmployeeShell()),
                    );
                  } else if (_selectedPortal == 2) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginScreen()));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _portalCard(int index, IconData icon, String title, String subtitle) {
    final selected = _selectedPortal == index;
    return InkWell(
      onTap: () => setState(() => _selectedPortal = index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 142),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.primaryLight,
            ),
            child: Icon(icon, color: AppColors.primary, size: 31),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: AppColors.text, fontSize: 12)),
            ],
          )),
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? AppColors.primary : AppColors.hint,
          ),
        ]),
      ),
    );
  }
}
