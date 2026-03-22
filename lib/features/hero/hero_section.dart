import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../core/constants/app_styles.dart';
import '../../widgets/neon_button.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    bool isMobile = constraints.maxWidth < 600;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hi, I\'m', style: AppStyles.heroSubtitle(constraints)),
          Text('Bhoma Ram', style: AppStyles.heroName(constraints)),
          const SizedBox(height: 16),
          TypeWriter(
            controller: TypeWriterController(
              text:
                  'I architect and engineer high-performance Flutter applications for mobile and web.',
              duration: const Duration(milliseconds: 40),
              repeat: true,
            ),
            builder: (context, value) {
              return Text(
                value.text,
                maxLines: 3,
                style: AppStyles.bodyText.copyWith(
                  fontSize: isMobile ? 16 : 18,
                  height: 1.4,
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          NeonButton(text: 'Download CV', onPressed: () {}),
        ],
      ),
    );
  }
}
