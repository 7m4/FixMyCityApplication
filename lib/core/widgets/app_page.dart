import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class AppPage extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomNavigationBar;
  final bool showBackButton;
  const AppPage({super.key, required this.title, required this.child, this.bottomNavigationBar, this.showBackButton = true});
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: showBackButton ? IconButton(onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back)) : null),
      body: SafeArea(child: child), bottomNavigationBar: bottomNavigationBar,
    ),
  );
}