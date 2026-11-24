import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/admin_widgets.dart';

class AdminAccountScreen extends StatelessWidget {
  final VoidCallback onLogout;
  const AdminAccountScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) => Column(children: [
    const AdminHeader(),
    const AdminPageHeader('حسابي', 'بيانات حساب المسؤول العام'),
    Card(color: Colors.white, elevation: 0, margin: const EdgeInsets.all(18), child: const Padding(
      padding: EdgeInsets.all(18),
      child: Column(children: [
        CircleAvatar(radius: 38, backgroundColor: AppColors.primaryLight, child: Icon(Icons.person, color: AppColors.primary, size: 42)),
        SizedBox(height: 12),
        Text('المسؤول العام', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text('admin@fixmycity.example', style: TextStyle(color: AppColors.text)),
        Divider(height: 28),
        ListTile(leading: Icon(Icons.verified_user_outlined), title: Text('نوع الحساب'), subtitle: Text('مسؤول عام')),
        ListTile(leading: Icon(Icons.apartment), title: Text('المؤسسة'), subtitle: Text('إدارة النظام')),
      ]),
    )),
    const Spacer(),
    Padding(padding: const EdgeInsets.all(20), child: SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: onLogout, icon: const Icon(Icons.logout), label: const Text('تسجيل الخروج')))),
  ]);
}
