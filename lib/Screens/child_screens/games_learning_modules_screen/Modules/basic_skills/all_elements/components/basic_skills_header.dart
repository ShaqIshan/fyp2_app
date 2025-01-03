import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class BasicSkillsHeader extends StatelessWidget {
  final VoidCallback onBack;
  final int currentStars;
  final int totalStars;

  const BasicSkillsHeader({
    super.key,
    required this.onBack,
    this.currentStars = 0,
    this.totalStars = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppTheme.childTurquoise,
                iconSize: 32,
                onPressed: onBack,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Basic Skills',
                  style: AppTheme.childHeadingLarge.copyWith(
                    color: AppTheme.childTurquoise,
                  ),
                ),
              ),
              _buildStarCounter(),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Complete activities to unlock new challenges!',
              style: AppTheme.childTitleLarge.copyWith(
                color: AppTheme.childTurquoise.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppTheme.childYellow.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            color: AppTheme.childYellow,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '$currentStars/$totalStars',
            style: AppTheme.childTitleLarge.copyWith(
              color: AppTheme.childYellow,
            ),
          ),
        ],
      ),
    );
  }
}
