// lib/screens/onboarding_screens/welcome/components/feature_card.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: AppTheme.primaryBrown,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTheme.titleMedium.copyWith(
              color: AppTheme.primaryBrown,
            ),
          ),
        ],
      ),
    );
  }
}
