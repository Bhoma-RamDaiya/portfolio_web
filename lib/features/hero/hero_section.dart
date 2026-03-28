import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/bloc/social_bloc/social_icon_bloc.dart';
import 'package:myapp/utils/helper.dart';
import 'package:myapp/widgets/social_icon.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../core/constants/app_styles.dart';
import '../../widgets/neon_button.dart';

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;

  const HeroSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    bool isMobile = constraints.maxWidth < 600;

    return BlocProvider(
      create: (_) => SocialIconBloc(),
      child:Container(
        // height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 32 : 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, I\'m', style: AppStyles.heroSubtitle(constraints)),
            Row(
              children: [
                Text('Bhoma Ram', style: AppStyles.heroName(constraints)),
                SizedBox(width: 30),

              ],
            ),
            const SizedBox(height: 16),
           isMobile?SizedBox(
             height: 40,
               child: buildTypeWriter(context , isMobile: true)):buildTypeWriter(context , isMobile: false),

            const SizedBox(height: 32),
            Row(children: [
              NeonButton(text: 'Download CV', onPressed: () {downloadCV();}),
              SizedBox(width: 16),
              SocialIcon(
                iconId: 'linkedin',
                icon: FontAwesomeIcons.linkedin,
                url: 'https://www.linkedin.com/in/bhoma-ram0506/',
                tooltip: 'LinkedIn',
              ),
              SizedBox(width: 16),
              SocialIcon(
                iconId: 'github',
                icon: FontAwesomeIcons.github,
                url: 'https://github.com/Bhoma-RamDaiya',
                tooltip: 'GitHub',
              ),
              SizedBox(width: 16),

            ],)

          ],
        ),
      ),
    );
  }
  Widget buildTypeWriter(BuildContext context , {bool isMobile = false }){
    return  TypeWriter(
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
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
