import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = AppColors.surface,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: backgroundColor == AppColors.surface ? AppColors.border : backgroundColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}