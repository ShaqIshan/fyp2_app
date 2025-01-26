// lib/screens/onboarding_screens/welcome/components/welcome_screen3.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'screen_template.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScreenTemplate(
      title: 'Interactive Learning',
      subtitle: 'Fun and Engaging Activities',
      illustration: _buildActivitiesShowcase(),
      description:
          'Develop essential skills through puzzles, drawing exercises, and interactive games.',
    );
  }

  Widget _buildActivitiesShowcase() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActivityItem(
                icon: Icons.extension,
                label: 'Puzzles',
                color: const Color(0xFFE0F7F6),
                iconColor: const Color(0xFF4ECDC4),
              ),
              const SizedBox(width: 32),
              _buildActivityItem(
                icon: Icons.draw,
                label: 'Drawing',
                color: const Color(0xFFF3E5F5),
                iconColor: const Color(0xFF9B7EDE),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildActivityItem(
            icon: Icons.gesture,
            label: 'Tracing',
            color: const Color(0xFFFFECB3),
            iconColor: const Color(0xFFFFB347),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            size: 40,
            color: iconColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
