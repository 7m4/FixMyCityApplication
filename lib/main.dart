import 'package:fix_my_city_application/features/register/presentation/screens/register_name_page.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const FixMyCityApp());
}

class FixMyCityApp extends StatelessWidget {
  const FixMyCityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fix My City',
      debugShowCheckedModeBanner: false,
      
      theme: AppTheme.lightTheme,
      home: RegisterNameScreen(),
    );
  }
}
