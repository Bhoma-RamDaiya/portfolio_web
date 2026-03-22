import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../data/models/skill_model.dart';

class SkillCard extends StatefulWidget {
  final Skill skill;
  const SkillCard({super.key, required this.skill});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnim = Tween<double>(begin: 0, end: widget.skill.proficiency)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translate(0.0, _hovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // ✅ Your theme color
          color: AppColors.glassmorphismBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // ✅ Your theme color — just alpha changes on hover
            color: _hovered
                ? AppColors.accent.withAlpha(200)
                : AppColors.accent.withAlpha(128),
            width: _hovered ? 1.5 : 1.0,
          ),
          boxShadow: _hovered
              ? [
            BoxShadow(
              // ✅ Your theme color
              color: AppColors.accent.withAlpha(45),
              blurRadius: 14,
              spreadRadius: 2,
            )
          ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              children: [
                  FaIcon(
                    widget.skill.icon,
                    size: 28,
                    color: AppColors.accent, // ✅ your theme color
                  ),
                const SizedBox(width: 5),
                Text(widget.skill.name, style: AppStyles.skillName),
              ],
            ),
            const SizedBox(height: 10),

            // Animated progress bar — your colors
            AnimatedBuilder(
              animation: _progressAnim,
              builder: (_, __) => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _progressAnim.value,
                  // ✅ Your theme colors
                  backgroundColor: AppColors.secondary,
                  valueColor: AlwaysStoppedAnimation(AppColors.accent),
                  minHeight: 5,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Percentage + years row — your style
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedBuilder(
                  animation: _progressAnim,
                  builder: (_, __) => Text(
                    '${(_progressAnim.value * 100).round()}%',
                    // ✅ Your style
                    style: AppStyles.bodyText,
                  ),
                ),
                Text(
                  '${widget.skill.years} yrs',
                  // ✅ Your style
                  style: AppStyles.bodyText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}