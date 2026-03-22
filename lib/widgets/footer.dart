
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_styles.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      color: AppColors.primary.withAlpha(26),
      child: Text(
        '© ${DateTime.now().year} Bhoma Ram. All Rights Reserved.',
        textAlign: TextAlign.center,
        style: AppStyles.bodyText.copyWith(color: Colors.grey[400]),
      ),
    );
  }
}
