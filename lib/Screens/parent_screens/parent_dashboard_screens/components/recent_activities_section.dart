import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/parents_screen_shared/shared_parents_screen/activity_card_widget.dart';

class RecentActivitiesSection extends StatelessWidget {
  const RecentActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activities',
              style: AppTheme.headingMedium,
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to full activity history
              },
              child: Text(
                'View All',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.accentGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 145,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              SizedBox(
                width: 280,
                child: ActivityCard(
                  date: '27/5/2024',
                  title: 'Daily Routine passed',
                  category: 'AAC Needs',
                  isPositive: true,
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 280,
                child: ActivityCard(
                  date: '27/5/2024',
                  title: 'Struggling with Animal Safari',
                  category: 'Social Communication',
                  isPositive: false,
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 280,
                child: ActivityCard(
                  date: '27/5/2024',
                  title: 'Completed Morning Exercise',
                  category: 'Physical Activity',
                  isPositive: true,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}
