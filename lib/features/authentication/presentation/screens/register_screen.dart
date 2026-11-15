import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../home/presentation/screens/app_shell.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _identity = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  int _step = 0;
  @override
  void dispose() {
    _name.dispose(); _identity.dispose(); _phone.dispose(); _email.dispose(); _password.dispose(); super.dispose();
  }
  String? _required(String? value) => value == null || value.trim().isEmpty ? 'هذا الحقل مطلوب' : null;
  void _next() {
    if (!_formKey.currentState!.validate()) return;
    if (_step < 2) { setState(() => _step++); return; }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AppShell()), (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    final titles = ['البيانات الشخصية', 'معلومات التواصل', 'كلمة المرور'];
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(title: const Text('إنشاء حساب جديد')),
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('إنشاء حساب • الخطوة ${_step + 1} من 3', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        LinearProgressIndicator(value: (_step + 1) / 3, color: AppColors.primary),
        const SizedBox(height: 24),
        Text(titles[_step], style: const TextStyle(color: AppColors.navy, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        if (_step == 0) ...[
          TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'الاسم الكامل'), validator: _required),
          const SizedBox(height: 16),
          TextFormField(controller: _identity, keyboardType: TextInputType.number, textDirection: TextDirection.ltr, decoration: const InputDecoration(labelText: 'الرقم الوطني'), validator: (v) => v == null || v.trim().length != 10 ? 'يجب أن يتكون الرقم الوطني من 10 أرقام' : null),
        ] else if (_step == 1) ...[
          TextFormField(controller: _phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'رقم الهاتف'), validator: _required),
          const SizedBox(height: 16),
          TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'البريد الإلكتروني'), validator: (v) => v == null || !v.contains('@') ? 'أدخل بريداً إلكترونياً صحيحاً' : null),
        ] else ...[
          TextFormField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'كلمة المرور'), validator: (v) => v == null || v.length < 8 ? 'استخدم 8 أحرف على الأقل' : null),
          const SizedBox(height: 12),
          const Text('هذه عملية تسجيل محلية لأغراض تجربة الواجهات فقط. لن يتم إنشاء حساب حقيقي قبل ربط الخادم.', style: TextStyle(color: AppColors.text)),
        ],
        const SizedBox(height: 28),
        AppButton(label: _step == 2 ? 'إنشاء الحساب التجريبي' : 'التالي', onPressed: _next),
        if (_step > 0) TextButton(onPressed: () => setState(() => _step--), child: const Text('رجوع')),
      ])))),
    ));
  }
}