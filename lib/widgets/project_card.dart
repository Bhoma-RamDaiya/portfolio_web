import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/project_card_event.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../data/models/project_model.dart';
import '../bloc/project_card_bloc.dart';
import '../bloc/project_card_state.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final BoxConstraints constraints;

  const ProjectCard({
    super.key,
    required this.project,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProjectCardBloc(),
      child: _ProjectCardView(
        project: project,
        constraints: constraints,
      ),
    );
  }
}

class _ProjectCardView extends StatelessWidget {
  final Project project;
  final BoxConstraints constraints;

  const _ProjectCardView({
    required this.project,
    required this.constraints,
  });

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 600;
    final double cardWidth =
    isMobile ? constraints.maxWidth * 0.9 : 350;
    final bool needsTruncation = project.description.length > 100;
    final String shortText = needsTruncation
        ? '${project.description.substring(0, 100)}...'
        : project.description;

    return SizedBox(
      width: cardWidth,
      child: BlocBuilder<ProjectCardBloc, ProjectCardState>(
        builder: (context, state) {
          return AnimatedContainer(
            constraints: BoxConstraints(minHeight: 300),
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.glassmorphismBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: state.isExpanded
                    ? AppColors.accent.withAlpha(160)
                    : AppColors.accent.withAlpha(77),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withAlpha(
                    state.isExpanded ? 40 : 20,
                  ),
                  blurRadius: state.isExpanded ? 18 : 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Title ──
                Text(
                  project.title,
                  style: AppStyles.skillName.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 12),

                // ── Description — auto truncates at 200 chars ──
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: state.isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Text(
                    shortText,
                    style: AppStyles.bodyText.copyWith(fontSize: 16),
                  ),
                  secondChild: Text(
                    project.description,
                    style: AppStyles.bodyText.copyWith(fontSize: 16),
                  ),
                ),

                // ── See more/less — only shown if > 200 chars ──
                if (needsTruncation) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => context
                        .read<ProjectCardBloc>()
                        .add(ToggleProjectCard()),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.isExpanded ? 'See less' : 'See more',
                          style: AppStyles.bodyText.copyWith(
                            color: AppColors.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        AnimatedRotation(
                          turns: state.isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 350),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.accent,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // ── Tech stack — always visible ──
                Text(
                  'Tech: ${project.tech}',
                  style: AppStyles.bodyText.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 16),

                // ── View Project button — untouched ──
                if (project.url != null)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () => _launch(project.url!),
                      child: Text(
                        'View Project',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}



