// lib/widgets/social_icon.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/bloc/social_bloc/social_icon_bloc.dart';
import 'package:myapp/bloc/social_bloc/social_icon_event.dart';
import 'package:myapp/bloc/social_bloc/social_ion_state.dart';
import 'package:myapp/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';


class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;
  final String tooltip;
  final String iconId;

  const SocialIcon({
    super.key,
    required this.icon,
    required this.url,
    required this.tooltip,
    required this.iconId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialIconBloc, SocialIconState>(
      builder: (context, state) {
        final hovered = state.isHovered(iconId);

        return Tooltip(
          message: tooltip,
          textStyle: const TextStyle(
            color: AppColors.accent,
            fontSize: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: AppColors.accent.withAlpha(100)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: MouseRegion(
            onEnter: (_) =>
                context.read<SocialIconBloc>().add(SocialIconHovered(iconId)),
            onExit: (_) =>
                context.read<SocialIconBloc>().add(SocialIconUnhovered(iconId)),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                final Uri uri = Uri.parse(url);
                if (uri.scheme == 'mailto') {
                  // Opens native email client / email compose box
                  await launchUrl(uri);
                } else {
                  // Opens links in new tab
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: hovered
                      ? AppColors.accent.withAlpha(26)  // same as NeonButton hover
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.accent,             // always visible like NeonButton
                  ),
                  boxShadow: hovered
                      ? [
                    BoxShadow(
                      color: AppColors.accent.withAlpha(153), // same as NeonButton
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                      : [],
                ),
                child: FaIcon(
                  icon,
                  size: 20,
                  color: AppColors.accent, // always accent colored, always visible
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

