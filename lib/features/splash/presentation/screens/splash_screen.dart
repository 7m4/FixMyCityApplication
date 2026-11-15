import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../onboarding/presentation/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const WelcomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) => const Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.location_city, color: Colors.white, size: 76),
        SizedBox(height: 18),
        Text('FixMyCity', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('معًا لحيّ أفضل', style: TextStyle(color: Color(0xFFB8D8CE), fontSize: 16)),
      ]))),
    ),
  );
}