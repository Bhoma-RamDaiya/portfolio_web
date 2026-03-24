import 'package:flutter/material.dart';
import 'package:myapp/core/constants/app_colors.dart';
import 'package:myapp/core/constants/home_section_key.dart';
class NavDrawer extends StatelessWidget {
  final void Function(GlobalKey key) onNavTap;
  const NavDrawer({super.key, required this.onNavTap});

  static final _navItems = [
    ('About', HomeSectionKeys.about),
    ('Skills', HomeSectionKeys.skills),
    ('Projects', HomeSectionKeys.projects),
    ('Experience', HomeSectionKeys.experience),
    ('Contact', HomeSectionKeys.contact),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Text(
                'Bhoma Ram',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(color: Colors.white24),
            for (final (label, key) in _navItems)
              ListTile(
                title: Text(label, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context); // closes the drawer
                  onNavTap(key);
                },
              ),
          ],
        ),
      ),
    );
  }
}