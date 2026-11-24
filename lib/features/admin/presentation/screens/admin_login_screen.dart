import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'admin_shell.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController(text: 'admin@fixmycity.example');
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    // Prototype only: connect this action to the admin authentication API later.
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminShell()));
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('دخول المسؤول العام')),
      body: Center(child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Card(color: Colors.white, child: Padding(
            padding: const EdgeInsets.all(22),
            child: Form(key: _formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.admin_panel_settings_outlined, size: 58, color: AppColors.primary),
              const SizedBox(height: 12),
              const Text('تسجيل الدخول إلى FixMyCity', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: AppColors.navy)),
              const SizedBox(height: 20),
              TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'البريد الإلكتروني'), validator: (v) => v == null || !v.contains('@') ? 'أدخل بريداً إلكترونياً صحيحاً' : null),
              const SizedBox(height: 12),
              TextFormField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور'), validator: (v) => v == null || v.isEmpty ? 'أدخل كلمة المرور' : null),
              const SizedBox(height: 18),
              SizedBox(width: double.infinity, child: FilledButton(onPressed: _login, child: const Text('دخول'))),
              const SizedBox(height: 8),
              const Text('وضع تجريبي: لا يوجد تحقق من حساب على الخادم حالياً.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.text, fontSize: 12)),
            ])),
          )),
        ),
      )),
    ),
  );
}
