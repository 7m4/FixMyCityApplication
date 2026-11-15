import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../authentication/presentation/screens/portal_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}
class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<(String, String, IconData)> _pages = const [
    ('التعرّف على التطبيق', 'أرسل بلاغاً عن مشاكل الحي مثل الحفر وتراكم النفايات وانقطاع الإنارة وتلف الأرصفة.', Icons.location_city_outlined),
    ('القسم والموقع', 'اختر القسم الإداري المسؤول ثم حدّد مكان المشكلة بدقة على الخريطة.', Icons.map_outlined),
    ('نوع المشكلة وتفاصيلها', 'اختر فئة المشكلة وأرفق صورة واضحة واكتب وصفاً مختصراً.', Icons.photo_camera_outlined),
    ('مراجعة البلاغ وإرساله', 'راجع تفاصيل البلاغ قبل الإرسال واحتفظ برقم التتبع بعد نجاح العملية.', Icons.fact_check_outlined),
    ('المتابعة والإشعارات', 'تابع حالة البلاغ وسجل التحديثات، وستصلك إشعارات عند حدوث تغيير.', Icons.notifications_active_outlined),
  ];
  @override
  void dispose() { _pageController.dispose(); super.dispose(); }
  void _continue() {
    if (_currentPage == _pages.length - 1) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PortalScreen()));
    } else {
      _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }
  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('الخطوة ${_currentPage + 1} من ${_pages.length}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PortalScreen())), child: const Text('تخطّي')),
        ]),
        const SizedBox(height: 8),
        LinearProgressIndicator(value: (_currentPage + 1) / _pages.length, color: AppColors.primary, backgroundColor: AppColors.border),
        const SizedBox(height: 24),
        Expanded(child: PageView.builder(
          controller: _pageController, itemCount: _pages.length,
          onPageChanged: (index) => setState(() => _currentPage = index),
          itemBuilder: (context, index) {
            final item = _pages[index];
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(item.$3, size: 76, color: AppColors.primary),
                const SizedBox(height: 28),
                Text(item.$1, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, color: AppColors.navy, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text(item.$2, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.text, height: 1.8, fontSize: 15)),
              ]),
            );
          },
        )),
        const SizedBox(height: 24),
        AppButton(label: _currentPage == _pages.length - 1 ? 'ابدأ الآن' : 'التالي', onPressed: _continue),
      ]))),
    ));
  }
}