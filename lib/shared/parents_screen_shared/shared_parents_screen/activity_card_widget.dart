// lib/shared/widgets/activity_card.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/parents_screen_shared/shared_parents_screen/activity_card_styles.dart';

class ActivityCard extends StatelessWidget {
  final String date;
  final String title;
  final String category;
  final bool isPositive;

  const ActivityCard({
    super.key,
    required this.date,
    required this.title,
    required this.category,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ActivityStyles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: $date',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.secondaryBrown,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTheme.titleMedium.copyWith(
              color: isPositive ? AppTheme.accentGreen : Colors.orange,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: ActivityStyles.badgeDecoration(),
            child: Text(
              category,
              style: AppTheme.bodyMedium.copyWith(
                fontSize: 12,
                color: AppTheme.secondaryBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
