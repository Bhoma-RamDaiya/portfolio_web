
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class NeonButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const NeonButton({super.key, required this.text, required this.onPressed});

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.accent.withAlpha(26) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.accent),
            boxShadow: _isHovered
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
            widget.text,
            style: const TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
