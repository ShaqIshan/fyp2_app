// lib/widgets/navigation/parent_bottom_nav.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavigation;
  final VoidCallback onChildModePressed;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onNavigation,
    required this.onChildModePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      color: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.school_rounded, 'Learning'),
                const SizedBox(width: 60), // Space for center button
                _buildNavItem(2, Icons.insert_chart_rounded, 'Reports'),
                _buildNavItem(3, Icons.calendar_today_rounded, 'Schedule'),
              ],
            ),
          ),
          _buildChildModeButton(),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onNavigation(index),
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  isSelected ? AppTheme.accentGreen : AppTheme.secondaryBrown,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.modifyStyle(
                AppTheme.bodyMedium,
                color:
                    isSelected ? AppTheme.accentGreen : AppTheme.secondaryBrown,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildModeButton() {
    return Positioned(
      top: -30,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.accentGreen.withOpacity(0.9),
                AppTheme.accentGreen,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.accentGreen.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onChildModePressed,
              customBorder: const CircleBorder(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.child_care_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Child',
                    style: AppTheme.bodyMedium.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
