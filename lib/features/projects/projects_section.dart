
import 'package:flutter/material.dart';
import '../../core/constants/app_styles.dart';
import '../../data/models/project_model.dart';
import '../../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  final BoxConstraints constraints;
   ProjectsSection({super.key, required this.constraints});
  final projects = [
    Project(
      title: 'Portfolio Website',
      description: 'A modern, responsive portfolio website built using Flutter Web to showcase my professional journey, technical skills, and project experience. Designed with a clean UI and smooth performance, it highlights my expertise in cross-platform development and attention to detail in user experience.',
      tech: 'Flutter, Dart , Bloc',
      url: 'https://github.com',
    ),
    Project(
      title: 'E-commerce App',
      description: 'A fully functional e-commerce mobile application developed with Flutter, featuring real-time product management with complete CRUD operations. Integrated Firebase for backend services and implemented efficient state management using GetX, ensuring smooth performance, scalability, and a seamless user experience.',
      tech: 'Flutter, dart , Firebase, GetX',
      url: 'https://github.com/Bhoma-RamDaiya/e-commerce-flutter.git',
    ),
    Project(
        title: 'Thought Throve Frontend',
        description: 'A dynamic and interactive blogging platform frontend built using React.js, enabling users to create, edit, and delete posts along with real-time interactions like likes and comments. Designed with a user-friendly interface and optimized for performance, providing a smooth content-sharing experience.',
        tech: 'React JS, Spring Boot (Backend Integration)',
        url: 'https://github.com/Bhoma-RamDaiya/ThoughtTroveFrontend.git'
    ),
    Project(
      title: 'Thoughtthrove Backend',
      description: 'A secure and scalable backend system developed using Spring Boot, powering a modern blogging platform. Implements robust authentication using JWT, efficient data handling with JPA and Hibernate, and follows clean architecture principles to ensure maintainability, performance, and security.',
      tech: 'Spring Boot, Java, JWT, JPA, Hibernate',
      url: 'https://github.com/Bhoma-RamDaiya/Thoughtthrove.git',
    ),
  ];
  @override
  Widget build(BuildContext context) {


    bool isMobile = constraints.maxWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 48),
      child: Column(
        children: [
          Text('Projects', style: AppStyles.sectionTitle(constraints)),
          const SizedBox(height: 32),
          if(isMobile)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 8 ,top: 8), // space for scrollbar
              child: Row(
                children: projects.map((project) => ProjectCard(project: project, constraints: constraints)).toList()
                    .expand((w) => [w, const SizedBox(width: 16)])
                    .toList()
                  ..removeLast(), // remove trailing SizedBox
              ),
            )
          else
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
