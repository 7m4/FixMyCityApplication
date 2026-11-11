import 'package:flutter/material.dart';
import 'package:fix_my_city_application/core/theme/app_colors.dart';
import 'package:fix_my_city_application/core/theme/app_text_styles.dart';
import 'package:fix_my_city_application/core/widgets/widgets.dart';

class RegisterNameScreen extends StatefulWidget {
  const RegisterNameScreen({super.key});

  @override
  State<RegisterNameScreen> createState() => _RegisterNameScreenState();
}

class _RegisterNameScreenState extends State<RegisterNameScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _birthDateController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _nationalIdController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  // دوال التحقق المؤقتة داخل الشاشة لحين نقلها لملف منفصل
  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }

  String? _nationalIdValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرقم الوطني مطلوب';
    }
    if (value.trim().length != 10) {
      return 'يجب أن يتكون الرقم الوطني من 10 أرقام';
    }
    return null;
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthDateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('أهلاً ${_firstNameController.text}، البيانات صحيحة!'),
          backgroundColor: AppColors.primary,
        ),
      );
      // الانتقال للخطوة الثانية
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  const StepProgressBar(totalSteps: 3, currentStep: 1),
                  const SizedBox(height: 12),

                  const Text(
                    'إنشاء حساب • الخطوة ١ من ٣',
                    style: AppTextStyles.stepIndicatorText,
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'لنبدأ بالتعرّف عليك',
                    style: AppTextStyles.heading,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'أدخل اسمك كما يظهر في هويتك الشخصية.',
                    style: AppTextStyles.subheading,
                  ),
                  const SizedBox(height: 24),

                  CustomTextField(
                    label: 'الاسم الأول',
                    hint: 'أدخل الاسم الأول',
                    controller: _firstNameController,
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'الاسم الأوسط',
                          hint: 'الاسم الأوسط',
                          controller: _middleNameController,
                          validator: _requiredValidator,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomTextField(
                          label: 'الاسم الأخير',
                          hint: 'الاسم الأخير',
                          controller: _lastNameController,
                          validator: _requiredValidator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    label: 'الرقم الوطني',
                    hint: 'أدخل الرقم الوطني',
                    controller: _nationalIdController,
                    keyboardType: TextInputType.number,
                    validator: _nationalIdValidator,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    label: 'تاريخ الميلاد',
                    hint: 'أدخل تاريخ الميلاد',
                    controller: _birthDateController,
                    readOnly: true,
                    onTap: _selectBirthDate,
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 28),

                  CustomPrimaryButton(
                    text: 'التالي',
                    onPressed: _onNextPressed,
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // الانتقال لشاشة تسجيل الدخول
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: 'لديك حساب بالفعل؟ ',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'تسجيل الدخول',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
