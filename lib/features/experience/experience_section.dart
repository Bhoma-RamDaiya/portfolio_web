import 'package:flutter/material.dart';

import '../../core/constants/app_styles.dart';
import '../../data/models/experience_model.dart';
import '../../widgets/experience_card.dart';

class ExperienceSection extends StatelessWidget {
  final BoxConstraints constraints;

  ExperienceSection({super.key, required this.constraints});

  final experiences = [
    Experience(
      company: 'WeServeCodes Pvt Ltd',
      role: 'Software Developer',
      period: 'Nov 2023 - Present',
      achievements: [
        'Built and shipped cross-platform Flutter applications for both web and mobile, serving real production users.',
        'Architected reusable component libraries reducing feature development time significantly across projects.',
        'Implemented BLoC and GetX state management patterns ensuring clean separation of concerns and testable code.',
        'Designed pixel-perfect UI/UX interfaces closely collaborating with designers to match Figma prototypes.',
        'Integrated CI/CD pipelines using Firebase App Distribution enabling automated builds and faster release cycles.',
        'Contributed to open-source Flutter packages and internal shared libraries used across multiple projects.',
      ],
    ),
    Experience(
      company: 'Abhiwan Technology',
      role: 'Software Engineer',
      period: 'Dec 2022 - Sept 2023',
      achievements: [
        'Developed and maintained cross-platform mobile applications using React Native and flutter .',
        'Built reusable React Native component libraries reducing redundant code and speeding up feature delivery across multiple projects.',
        'Implemented JavaScript business logic and API integrations using REST services ensuring smooth data flow between frontend and backend.',
        'Contributed to React.js web interfaces translating Figma designs into responsive pixel-perfect UI components.',
        'Collaborated with backend teams to define API contracts and optimise payload structures improving app performance.',
        'Participated in code reviews enforcing best practices clean code standards and maintaining high codebase quality.',
        'Debugged and resolved production issues across React Native and React.js applications reducing crash rates and improving user retention.',
      ],
    ),
    Experience(
      company: 'Eratronics Pvt Ltd',
      role: 'Trainee Engineer',
      period: 'Apr 2022 - Oct 2022',
      achievements: [
        'Built and tested RESTful APIs using Spring Boot and Java laying a strong foundation in backend development and MVC architecture.',
        'Implemented JWT based authentication and authorization mechanisms ensuring secure access control across application endpoints.',
        'Worked with JPA and Hibernate for database interactions writing optimised queries and managing entity relationships in MySQL.',
        'Developed dynamic frontend components using JavaScript and integrated them with Spring Boot backend APIs via REST calls.',
        'Gained hands-on experience with the full development lifecycle from requirement gathering to deployment in a professional team environment.',
        'Wrote unit tests for backend services using JUnit ensuring code reliability and reducing regression bugs during feature additions.',
      ],
    ),
  ];

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
          Text('Experience', style: AppStyles.sectionTitle(constraints)),
          const SizedBox(height: 32),
          if (isMobile)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 8, top: 8),
              // space for scrollbar
              child: Row(
                children:
                    experiences
                        .map(
                          (project) => ExperienceCard(
                            experience: project,
                            constraints: constraints,
                          ),
                        )
                        .toList()
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
              children: experiences
                  .map(
                    (experience) => ExperienceCard(
                      experience: experience,
                      constraints: constraints,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
