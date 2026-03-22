
import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';
import '../../data/models/project_model.dart';
import '../../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  final BoxConstraints constraints;
  const ProjectsSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final projects = [
      Project(
        title: 'Portfolio Website',
        description: 'This very website, built with Flutter and running on the web.',
        tech: 'Flutter, Dart',
        url: 'https://github.com',
      ),
      Project(
        title: 'E-commerce App',
        description: 'A fully functional e-commerce app for a fictional store.',
        tech: 'Flutter, Firebase, Stripe',
      ),
      Project(
        title: 'Chat App',
        description: 'A real-time chat application.',
        tech: 'Flutter, Firebase',
      ),
      Project(
        title: 'Thoughtthrove',
        description: 'It is secure, scalable backend application built using Spring Boot, designed to power a modern blogging platform.',
        tech: 'Spring Boot ,Java,JWT , JPA, Hibernate, ',
        url: 'https://github.com/Bhoma-RamDaiya/Thoughtthrove.git'
      ),
    ];

    bool isMobile = constraints.maxWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 48),
      child: Column(
        children: [
          Text('Projects', style: AppStyles.sectionTitle(constraints)),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: projects.map((project) => ProjectCard(project: project, constraints: constraints)).toList(),
          ),
        ],
      ),
    );
  }
}
