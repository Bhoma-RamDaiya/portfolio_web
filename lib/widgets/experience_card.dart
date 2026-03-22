import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/experience/experience_card_bloc.dart';
import 'package:myapp/bloc/experience/experience_card_event.dart';
import 'package:myapp/bloc/experience/experience_card_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../data/models/experience_model.dart';


class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final BoxConstraints constraints;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExperienceCardBloc(),
      child: _ExperienceCardView(
        experience: experience,
        constraints: constraints,
      ),
    );
  }
}

class _ExperienceCardView extends StatelessWidget {
  final Experience experience;
  final BoxConstraints constraints;

  const _ExperienceCardView({
    required this.experience,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {

    final bool isMobile = constraints.maxWidth < 600;
    final double cardWidth = isMobile ? constraints.maxWidth * 0.9 : 500;

    final String fullText = experience.achievements.join(' ');
    final bool needsTruncation = fullText.length > 200;

    final List<String> collapsedAchievements =
    experience.achievements.length > 2
        ? experience.achievements.sublist(0, 2)
        : experience.achievements;

    return SizedBox(
      width: cardWidth,
      child: BlocBuilder<ExperienceCardBloc, ExperienceCardState>(
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
              mainAxisSize: MainAxisSize.min,
              children: [

                // ── Role + Company — always visible ──
                Text(
                  '${experience.role} at ${experience.company}',
                  style: AppStyles.skillName.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  experience.period,
                  style: AppStyles.bodyText.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: state.isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,

                  // Collapsed — first 2 achievements only
                  firstChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: collapsedAchievements
                        .map((a) => _AchievementItem(text: a))
                        .toList(),
                  ),

                  // Expanded — all achievements
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: experience.achievements
                        .map((a) => _AchievementItem(text: a))
                        .toList(),
                  ),
                ),

                if (needsTruncation) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => context
                        .read<ExperienceCardBloc>()
                        .add(ToggleExperienceCard()),
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
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Reusable achievement bullet item ──
class _AchievementItem extends StatelessWidget {
  final String text;
  const _AchievementItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppStyles.bodyText.copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
