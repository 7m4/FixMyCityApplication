import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen())), child: const Text('تخطّي')),
            const Text('FixMyCity', style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 22),
          const Text('صوتك خطوة نحو مدينة أفضل', style: TextStyle(color: AppColors.navy, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('تعرّف على التطبيق وكيف يساعدك على الإبلاغ عن مشاكل حيّك ومتابعتها.', style: TextStyle(color: AppColors.text, height: 1.7)),
          const SizedBox(height: 24),
          Expanded(child: Container(
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(18)),
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.play_circle_outline, color: AppColors.primary, size: 72),
              SizedBox(height: 16),
              Text('فيديو تعريفي', style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: Text('سيتم إضافة الفيديو التعريفي لاحقاً. يمكنك المتابعة للتعرّف على خطوات استخدام التطبيق.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.text, height: 1.6))),
            ]),
          )),
          const SizedBox(height: 24),
          AppButton(label: 'متابعة الشرح', onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()))),
        ]),
      )),
    ),
  );
}