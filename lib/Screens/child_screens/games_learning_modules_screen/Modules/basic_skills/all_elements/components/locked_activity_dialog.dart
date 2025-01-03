import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../../../../../../../models/childs_models/child_learning_modules_games/basic_skills/basic_activity.dart';

class LockedActivityDialog extends StatelessWidget {
  final BasicActivity activity;

  const LockedActivityDialog({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock_rounded,
            size: 48,
            color: activity.color,
          ),
          const SizedBox(height: 16),
          Text(
            'Activity Locked',
            style: AppTheme.childHeadingMedium.copyWith(
              color: activity.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete previous activities to earn ${activity.requiredStars} stars and unlock this activity!',
            textAlign: TextAlign.center,
            style: AppTheme.childBodyText,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: activity.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
            ),
            child: Text(
              'OK',
              style: AppTheme.childBodyText.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
