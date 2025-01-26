// lib/screens/onboarding_screens/welcome/components/screen_template.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class WelcomeScreenTemplate extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget illustration;
  final String description;

  const WelcomeScreenTemplate({
    super.key,
    required this.title,
    required this.subtitle,
    required this.illustration,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTheme.displayLarge.copyWith(
                fontSize: 32,
                color: AppTheme.primaryBrown,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTheme.titleLarge.copyWith(
                color: AppTheme.secondaryBrown,
              ),
            ),
            const Spacer(),
            illustration,
            const Spacer(),
            Text(
              description,
              style: AppTheme.bodyLarge.copyWith(
                color: AppTheme.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 170), // Space for navigation
          ],
        ),
      ),
    );
  }
}
