import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StepProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final Color? activeColor;
  final Color? inactiveColor;

  const StepProgressBar({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final bool isActive = index < currentStep;
        return Expanded(
          child: Container(
            height: 5,
            margin: EdgeInsets.only(left: index == totalSteps - 1 ? 0 : 8),
            decoration: BoxDecoration(
              color: isActive
                  ? (activeColor ?? AppColors.primary)
                  : (inactiveColor ?? AppColors.inactiveStep),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    );
  }
}
