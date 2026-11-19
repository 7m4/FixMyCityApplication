import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../home/presentation/screens/app_shell.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identityController = TextEditingController(text: '1234567890');
  final _passwordController = TextEditingController(text: 'Test@1234');
  @override
  void dispose() { _identityController.dispose(); _passwordController.dispose(); super.dispose(); }
  void _login() {
    if (!_formKey.currentState!.validate()) return;
    // Local prototype only: a real authentication API is not connected yet.
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AppShell()), (route) => false);
  }
  @override
  Widget build(BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: Scaffold(
    backgroundColor: AppColors.background,
    body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 72),
      Center(child: Container(width: 100, height: 100, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(24)), child: const Icon(Icons.location_city, color: Colors.white, size: 64))),
      const SizedBox(height: 12),
      const Center(child: Text('FixMyCity', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 25))),
      const SizedBox(height: 32),
      const Text('مرحباً بعودتك', textAlign: TextAlign.center, style: TextStyle(color: AppColors.navy, fontSize: 26, fontWeight: FontWeight.bold , fontFamily: 'Cairo')),
      const SizedBox(height: 8),
      const Text('أدخل بيانات الدخول للوصول إلى حسابك.', style: TextStyle(color: AppColors.text)),
      const SizedBox(height: 24),
      const Text('رقم الهوية', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy , fontFamily: 'Cairo')),
      const SizedBox(height: 8),
      TextFormField(controller: _identityController, keyboardType: TextInputType.number, textDirection: TextDirection.ltr, decoration: const InputDecoration(hintText: 'أدخل رقم الهوية'), validator: (value) => value == null || value.trim().length != 10 ? 'أدخل رقم هوية من 10 أرقام' : null),
      const SizedBox(height: 16),
      const Text('كلمة المرور', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
      const SizedBox(height: 8),
      TextFormField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(hintText: 'أدخل كلمة المرور'), validator: (value) => value == null || value.length < 6 ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل' : null),
      const SizedBox(height: 12),
      const SizedBox(height: 36),
      AppButton(label: 'تسجيل الدخول', onPressed: _login),
      const SizedBox(height: 12),
      AppButton(label: 'إنشاء حساب جديد', outlined: true, onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()))),
    ])))),
  ));
}