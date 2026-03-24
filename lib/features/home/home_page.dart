import 'package:flutter/material.dart';
import 'package:myapp/core/constants/home_section_key.dart';
import 'package:myapp/widgets/nav_drawer.dart';

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
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Header(onNavTap: _scrollTo),
      ),
      // Drawer lives on Scaffold, not inside Header
      drawer: isMobile
          ? NavDrawer(onNavTap: _scrollTo)
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = MediaQuery.of(context).size.width;
          final constraints = BoxConstraints(maxWidth: width);
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: HeroSection(constraints: constraints)),
              SliverToBoxAdapter(child: AboutSection(constraints: constraints, key: HomeSectionKeys.about)),
              SliverToBoxAdapter(child: SkillsSection(constraints: constraints, key: HomeSectionKeys.skills)),
              SliverToBoxAdapter(child: ProjectsSection(constraints: constraints, key: HomeSectionKeys.projects)),
              SliverToBoxAdapter(child: ExperienceSection(constraints: constraints, key: HomeSectionKeys.experience)),
              SliverToBoxAdapter(child: ContactSection(constraints: constraints, key: HomeSectionKeys.contact)),
            ],
          );
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
