import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/demo/demo_screens.dart';

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
      home: const DemoRootScreen(),
    );
  }
}
