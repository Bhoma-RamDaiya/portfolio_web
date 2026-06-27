import 'package:flutter/material.dart';

import '../../core/constants/app_styles.dart';

class AboutSection extends StatelessWidget {
  final BoxConstraints constraints;

  const AboutSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    bool isMobile = constraints.maxWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: 48,
      ),
      child: Column(
        children: [
          Text('About Me', style: AppStyles.sectionTitle(constraints)),
          const SizedBox(height: 32),
          if (isMobile == false)
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCircleImage(context, isMobile: false),
                SizedBox(width: 48,),
                Expanded(
                  child: Text(
                    'I am a software engineer with a passion for building beautiful and functional applications. I have experience in various technologies, but my main focus is on Flutter & SpringBoot. I am always eager to learn new things and take on new challenges.',
                    style: AppStyles.bodyText,
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
              buildCircleImage(context, isMobile: true),
                const SizedBox(height: 32),
                Text(
                  'I am a software engineer with a passion for building beautiful and functional applications. I have experience in various technologies, but my main focus is on Flutter. I am always eager to learn new things and take on new challenges.',
                  style: AppStyles.bodyText,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
        ],
      ),
    );
  }

  buildCircleImage(BuildContext context, {bool isMobile = false}) {
    return CircleAvatar(
      radius: isMobile ? 120 : 120,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.asset(
          'assets/cv/portfolio_image.jpeg',
          width: isMobile ? 240 : 240,
          height: isMobile ? 240 : 240,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 80);
          },
        ),
      ),
    );
  }
}
