import 'package:flutter/material.dart';

class CustomAuthHeader extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  const CustomAuthHeader({
    super.key,
    this.onBackPressed,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // اسم التطبيق على اليمين (في وضع RTL)
        const Text(
          'FixMyCity',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF087F78),
          ),
        ),

        // زر الرجوع على اليسار
        if (showBackButton)
          TextButton(
            onPressed: onBackPressed ?? () => Navigator.maybePop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'رجوع',
              style: TextStyle(
                color: Color(0xFF5A6B6C),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
