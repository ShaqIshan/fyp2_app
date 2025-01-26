// lib/screens/onboarding_screens/welcome/components/welcome_screen4.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'screen_template.dart';

class WelcomeScreen4 extends StatelessWidget {
  const WelcomeScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScreenTemplate(
      title: 'Parent Guided',
      subtitle: "Support Your Child's Journey",
      illustration: Center(child: _buildParentGuidanceIllustration()),
      description:
          'Work together with your child through activities while trying out the activities for their development.',
    );
  }

  Widget _buildParentGuidanceIllustration() {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBrown.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.family_restroom,
            size: 80,
            color: AppTheme.accentGreen,
          ),
          const SizedBox(height: 24),
          Text(
            'Together Every Step',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.primaryBrown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Guide and celebrate\nyour child's progress",
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.secondaryBrown,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
