
import 'package:flutter/material.dart';
import 'package:myapp/core/constants/home_section_key.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class Header extends StatelessWidget {
  final void Function(GlobalKey key) onNavTap;
  const Header({super.key , required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(200),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withAlpha(100),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Bhoma Ram', style: AppStyles.heroName(const BoxConstraints(maxWidth: 1200)).copyWith(fontSize: 24)),
          Row(
            children: [
              _navButton('About',HomeSectionKeys.about),
              const SizedBox(width: 24),
              _navButton('Skills',HomeSectionKeys.skills),
              const SizedBox(width: 24,),
              _navButton('Projects',HomeSectionKeys.projects),
              const SizedBox(width: 24),
              _navButton('Experience',HomeSectionKeys.experience),
              const SizedBox(width: 24),
              _navButton('Contact',HomeSectionKeys.contact),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton(String text ,GlobalKey key) {
    return TextButton(
      onPressed: () => onNavTap(key),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
