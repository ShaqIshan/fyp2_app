import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../../../../../../../models/childs_models/child_learning_modules_games/basic_skills/basic_activity.dart';

class ActivityCard extends StatelessWidget {
  final BasicActivity activity;
  final VoidCallback onTap;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 153, // Reduced from 160 to prevent overflow
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: activity.color.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    16), // Reduced from 20 to give more space
                child: Row(
                  children: [
                    _buildActivityIcon(),
                    const SizedBox(width: 16), // Reduced from 20
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.title,
                            style: AppTheme.childTitleLarge.copyWith(
                              color: activity.color,
                            ),
                          ),
                          const SizedBox(height: 4), // Reduced from 8
                          Text(
                            activity.description,
                            style: AppTheme.childBodyText.copyWith(
                              color: Colors.grey[600],
                              fontSize: 14, // Slightly smaller font
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          _buildDifficultyBadge(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (activity.isLocked) _buildLockedOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityIcon() {
    return Container(
      width: 56, // Reduced from 64
      height: 56, // Reduced from 64
      decoration: BoxDecoration(
        color: activity.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14), // Reduced from 16
      ),
      child: Icon(
        activity.icon,
        size: 28, // Reduced from 32
        color: activity.color,
      ),
    );
  }

  Widget _buildDifficultyBadge() {
    final isEasy = activity.difficulty == 'Easy';
    final color = isEasy ? AppTheme.childSoftGreen : AppTheme.childOrange;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10, // Reduced from 12
        vertical: 4, // Reduced from 6
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10), // Reduced from 12
      ),
      child: Text(
        activity.difficulty,
        style: AppTheme.childBodyText.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 13, // Slightly smaller font
        ),
      ),
    );
  }

  Widget _buildLockedOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_rounded,
              color: Colors.white,
              size: 28, // Reduced from 32
            ),
            const SizedBox(height: 4), // Reduced from 8
            Text(
              '${activity.requiredStars} stars needed',
              style: AppTheme.childBodyText.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13, // Slightly smaller font
              ),
            ),
          ],
        ),
      ),
    );
  }
}
