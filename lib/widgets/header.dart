import 'package:flutter/material.dart';
import 'package:myapp/core/constants/home_section_key.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class Header extends StatelessWidget {
  final void Function(GlobalKey key) onNavTap;
  const Header({super.key, required this.onNavTap});

  static final _navItems = [
    ('About', HomeSectionKeys.about),
    ('Skills', HomeSectionKeys.skills),
    ('Projects', HomeSectionKeys.projects),
    ('Experience', HomeSectionKeys.experience),
    ('Contact', HomeSectionKeys.contact),
  ];



  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: 5,
      ),
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
          Text(
            'Bhoma Ram',
            style: AppStyles.heroName(
              const BoxConstraints(maxWidth: 1200),
            ).copyWith(fontSize: isMobile ? 18 : 24),
          ),
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )
          else
            Row(
              children: [
                for (int i = 0; i < _navItems.length; i++) ...[
                  if (i > 0) const SizedBox(width: 24),
                  _navButton(_navItems[i].$1, _navItems[i].$2),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _navButton(String text, GlobalKey key) {
    return TextButton(
      onPressed: () => onNavTap(key),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}