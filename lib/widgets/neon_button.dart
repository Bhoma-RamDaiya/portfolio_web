import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/button_bloc/hover_cubit.dart';
import '../core/constants/app_colors.dart';


class NeonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const NeonButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HoverCubit(),
      child: _NeonButtonView(text: text, onPressed: onPressed),
    );
  }
}

class _NeonButtonView extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _NeonButtonView({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HoverCubit>();

    return BlocBuilder<HoverCubit, HoverState>(
      builder: (context, state) {
        final hovered = state.isHovered;

        return MouseRegion(
          // Desktop / web hover
          onEnter: (_) => cubit.onHoverEnter(),
          onExit:  (_) => cubit.onHoverExit(),
          child: GestureDetector(
            onTap: () {
              onPressed();
            },
            // ── Touch press-and-release for mobile browsers ──
            onTapDown:   (_) => cubit.onHoverEnter(),
            onTapUp:     (_) => cubit.onHoverExit(),
            onTapCancel:  () => cubit.onHoverExit(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: hovered
                    ? AppColors.accent.withAlpha(26)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.accent),
                boxShadow: hovered
                    ? [
                  BoxShadow(
                    color: AppColors.accent.withAlpha(153),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
                    : [],
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}