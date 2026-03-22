
import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';

class AboutSection extends StatelessWidget {
  final BoxConstraints constraints;
  const AboutSection({ super.key, required this.constraints , });

  @override
  Widget build(BuildContext context) {
    bool isMobile = constraints.maxWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 48),
      child: Column(
        children: [
          Text('About Me', style: AppStyles.sectionTitle(constraints)),
          const SizedBox(height: 32),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: isMobile ? 80 : 120,
                backgroundImage: const NetworkImage('https://avatars.githubusercontent.com/u/132533989?v=4'),
              ),
              SizedBox(width: isMobile ? 0 : 48, height: isMobile ? 32 : 0),
              Expanded(
                child: Text(
                  'I am a software engineer with a passion for building beautiful and functional applications. I have experience in various technologies, but my main focus is on Flutter. I am always eager to learn new things and take on new challenges.',
                  style: AppStyles.bodyText,
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
