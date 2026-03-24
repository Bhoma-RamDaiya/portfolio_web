
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_styles.dart';
import '../../data/models/skill_model.dart';
import '../../widgets/skill_card.dart';

class SkillsSection extends StatelessWidget {
  final BoxConstraints constraints;
   SkillsSection({super.key, required this.constraints});
  final skills = [
    Skill(name: 'Flutter', proficiency: 0.9, years: 2 , icon:  FontAwesomeIcons.mobileScreen),
    Skill(name: 'Dart', proficiency: 0.8, years: 2, icon: FontAwesomeIcons.dartLang,),
    Skill(name: 'JAVA', proficiency: 0.8, years: 2,icon: FontAwesomeIcons.java,),
    Skill(name: 'SpringBoot', proficiency: 0.8, years: 2,icon: FontAwesomeIcons.leaf,),
    Skill(name: 'React Native', proficiency: 0.8, years: 2,icon: FontAwesomeIcons.react,),
    Skill(name: 'React', proficiency: 0.8, years: 2,icon: FontAwesomeIcons.react,),
    Skill(name: 'HTML', proficiency: 0.8, years: 2,icon: FontAwesomeIcons.html5,),
    Skill(name: 'CSS', proficiency: 0.8, years: 2,icon: FontAwesomeIcons.css,),
    Skill(name: 'Firebase', proficiency: 0.7, years: 2,icon: FontAwesomeIcons.fire,),
    Skill(name: 'Git', proficiency: 0.8, years: 4,icon: FontAwesomeIcons.git,),
    Skill(name: 'Get X', proficiency: 0.6, years: 2,icon: FontAwesomeIcons.bolt,),
    Skill(name: 'Bloc', proficiency: 0.5, years: 2,icon: FontAwesomeIcons.cubes,),
  ];
  @override
  Widget build(BuildContext context) {


    bool isMobile = constraints.maxWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 48),
      child: Column(
        children: [
          Text('Skills', style: AppStyles.sectionTitle(constraints)),
          const SizedBox(height: 32),
          if (isMobile)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 8 ,top: 8), // space for scrollbar
              child: Row(
                children: buildSkillsWidget()
                    .expand((w) => [w, const SizedBox(width: 16)])
                    .toList()
                  ..removeLast(), // remove trailing SizedBox
              ),
            )
          else
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.start,
              children: buildSkillsWidget(),
            ),
        ],
      ),
    );
  }
  List<Widget> buildSkillsWidget(){
    return skills.asMap().entries.map((entry) {
      final index = entry.key;
      final skill = entry.value;
      return SizedBox(
        width: 210,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + (index * 70)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child,
              ),
            );
          },
          child: SkillCard(skill: skill),
        ),
      );
    }).toList();
  }
}
