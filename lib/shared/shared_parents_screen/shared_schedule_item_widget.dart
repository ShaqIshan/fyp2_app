// lib/shared/widgets/schedule_item.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/shared_parents_screen/activity_card_styles.dart';

class ScheduleItem extends StatelessWidget {
  final String time;
  final String activity;
  final String status;

  const ScheduleItem({
    super.key,
    required this.time,
    required this.activity,
    required this.status,
  });

  IconData _getActivityIcon(String activity) {
    switch (activity.toLowerCase()) {
      case 'learn':
        return Icons.school;
      case 'play':
        return Icons.sports_esports;
      case 'sleep':
        return Icons.bedtime;
      default:
        return Icons.calendar_today;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: ActivityStyles.cardDecoration,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: ActivityStyles.badgeDecoration(
              color: AppTheme.accentGreen,
            ),
            child: Icon(
              _getActivityIcon(activity),
              color: AppTheme.accentGreen,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$time - $activity',
                  style: AppTheme.titleMedium,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: ActivityStyles.badgeDecoration(
              color: AppTheme.accentGreen,
            ),
            child: Text(
              status,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.accentGreen,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
