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
              children: [
                // Space for Child button
                const SizedBox(width: 100),
                // Other navigation items
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(0, Icons.home_rounded, 'Home'),
                      _buildNavItem(
                          1, Icons.calendar_today_rounded, 'Schedule'),
                      _buildNavItem(2, Icons.insert_chart_rounded, 'Reports'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Pop-out Child button
          Positioned(
            left: 20,
            top: -25,
            child: _buildChildModeButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onNavigation(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppTheme.accentGreen : AppTheme.secondaryBrown,
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
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildModeButton() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
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
    );
  }
}
