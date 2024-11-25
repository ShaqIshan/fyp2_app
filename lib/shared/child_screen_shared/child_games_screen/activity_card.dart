import 'package:flutter/material.dart';
import 'package:fyp2_app/models/activity_category.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/child_screen_shared/child_games_screen/child_game_styles.dart';

class ActivityCard extends StatelessWidget {
  final ActivityCategory category;
  final VoidCallback onTap;

  const ActivityCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ChildGameStyles.cardDecoration(category.backgroundColor),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  category.icon,
                  size: 120,
                  color: category.backgroundColor.withOpacity(0.2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      category.icon,
                      size: 40,
                      color: category.backgroundColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      category.title,
                      style: AppTheme.childHeadingMedium.copyWith(
                        color: category.backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: ChildGameStyles.categoryBadgeDecoration(
                        category.backgroundColor,
                      ),
                      child: Text(
                        category.subtitle,
                        style: AppTheme.childBodyText.copyWith(
                          color: category.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
