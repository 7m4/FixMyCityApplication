import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import 'login_screen.dart';

class PortalScreen extends StatefulWidget {
  const PortalScreen({super.key});
  @override
  State<PortalScreen> createState() => _PortalScreenState();
}
class _PortalScreenState extends State<PortalScreen> {
  int _selectedPortal = 0;
  @override
  Widget build(BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: Scaffold(
    backgroundColor: AppColors.background,
    body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 24),
      const Text('اختر بوابة الدخول', style: TextStyle(color: AppColors.navy, fontSize: 26, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('اختر البوابة المناسبة للمتابعة', style: TextStyle(color: AppColors.text)),
      const SizedBox(height: 24),
      _portalCard(0, Icons.person_outline, 'بوابة المواطن', 'قدّم بلاغاتك وتابع حالتها في مدينتك.'),
      const SizedBox(height: 16),
      _portalCard(1, Icons.work_outline, 'بوابة الموظف', 'تابع مهامك وقم بإدارتها داخل مؤسستك.'),
      const Spacer(),
      AppButton(label: 'دخول', onPressed: () {
        if (_selectedPortal == 1) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('بوابة الموظف غير متاحة في نسخة تجربة المواطن.')));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
      }),
    ]))),
  ));
  Widget _portalCard(int index, IconData icon, String title, String subtitle) {
    final selected = _selectedPortal == index;
    return InkWell(onTap: () => setState(() => _selectedPortal = index), borderRadius: BorderRadius.circular(16), child: Container(
      height: 190, padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 2 : 1)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleAvatar(radius: 32, backgroundColor: AppColors.primaryLight, child: Icon(icon, color: AppColors.primary, size: 34)),
        const SizedBox(height: 12),
        Text(title, style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.text, fontSize: 12)),
      ]),
    ));
  }
}