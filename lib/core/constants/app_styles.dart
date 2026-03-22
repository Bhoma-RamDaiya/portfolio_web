
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle heroName(BoxConstraints constraints) {
    bool isMobile = constraints.maxWidth < 600;
    return GoogleFonts.montserrat(
      fontSize: isMobile ? 42 : 72,
      fontWeight: FontWeight.bold,
      color: AppColors.font,
      letterSpacing: 1.5,
      shadows: [
        Shadow(
          color: AppColors.accent.withAlpha(128),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static TextStyle heroSubtitle(BoxConstraints constraints) {
    bool isMobile = constraints.maxWidth < 600;
    return GoogleFonts.montserrat(
      fontSize: isMobile ? 18 : 28,
      color: AppColors.font.withAlpha(204),
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle sectionTitle(BoxConstraints constraints) {
    bool isMobile = constraints.maxWidth < 600;
    return GoogleFonts.montserrat(
      fontSize: isMobile ? 36 : 48,
      fontWeight: FontWeight.w800,
      color: AppColors.accent,
      letterSpacing: 1.2,
    );
  }

  static final TextStyle bodyText = GoogleFonts.openSans(
    fontSize: 18,
    color: AppColors.font.withAlpha(204),
    height: 1.7,
  );

  static final TextStyle skillName = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.font,
  );

  static final TextStyle buttonText = GoogleFonts.montserrat(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    letterSpacing: 1.2,
  );

  static final TextStyle navLink = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.font,
  );
}
