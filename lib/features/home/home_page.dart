import 'package:flutter/material.dart';
import 'package:myapp/core/constants/home_section_key.dart';

import '../../widgets/footer.dart';
import '../../widgets/header.dart';
import '../about/about_section.dart';
import '../contact/contact_section.dart';
import '../experience/experience_section.dart';
import '../hero/hero_section.dart';
import '../projects/projects_section.dart';
import '../skills/skills_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ScrollController _scrollController = ScrollController();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Header(onNavTap: _scrollTo),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(child: HeroSection(constraints: BoxConstraints())),
          SliverToBoxAdapter(
            child: AboutSection(
              constraints: BoxConstraints(),
              key: HomeSectionKeys.about,
            ),
          ),
          SliverToBoxAdapter(
            child: SkillsSection(
              constraints: BoxConstraints(),
              key: HomeSectionKeys.skills,
            ),
          ),
          SliverToBoxAdapter(
            child: ProjectsSection(
              constraints: BoxConstraints(),
              key: HomeSectionKeys.projects,
            ),
          ),
          SliverToBoxAdapter(
            child: ExperienceSection(
              constraints: BoxConstraints(),
              key: HomeSectionKeys.experience,
            ),
          ),
          SliverToBoxAdapter(
            child: ContactSection(
              constraints: BoxConstraints(),
              key: HomeSectionKeys.contact,
            ),
          ),
        ],
      ),
      // ListView(
      //   controller: _scrollController,
      //   children: [
      //     HeroSection(constraints: const BoxConstraints()),
      //     AboutSection(constraints :const BoxConstraints() ,key: HomeSectionKeys.about),
      //     SkillsSection(constraints :const BoxConstraints() , key: HomeSectionKeys.skills),
      //     ProjectsSection(constraints :const BoxConstraints() ,key: HomeSectionKeys.projects),
      //     ExperienceSection(constraints :const BoxConstraints() ,key: HomeSectionKeys.experience),
      //     ContactSection(constraints :const BoxConstraints() ,key: HomeSectionKeys.contact),
      //   ],
      // ),
      bottomNavigationBar: const Footer(),
    );
  }
}
