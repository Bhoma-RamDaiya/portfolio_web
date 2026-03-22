
import 'package:flutter/material.dart';
import '../about/about_section.dart';
import '../contact/contact_section.dart';
import '../experience/experience_section.dart';
import '../hero/hero_section.dart';
import '../projects/projects_section.dart';
import '../skills/skills_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                HeroSection(constraints: constraints),
                AboutSection(constraints: constraints),
                SkillsSection(constraints: constraints),
                ProjectsSection(constraints: constraints),
                ExperienceSection(constraints: constraints),
                ContactSection(constraints: constraints),
              ],
            ),
          );
        },
      ),
    );
  }
}
