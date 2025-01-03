// lib/screens/child_screens/child_home_screen/components/level_card.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/models/childs_models/level_data.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class LevelCard extends StatelessWidget {
  final LevelData level;

  const LevelCard({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = level.isCompleted || level.isUnlocked;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isActive ? 1.0 : 0.6,
      child: Transform.scale(
        scale: isActive ? 1.0 : 0.95,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.childCream,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: level.color.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: _buildCardContent(isActive),
        ),
      ),
    );
  }

  Widget _buildCardContent(bool isActive) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: isActive
            ? () {
                // TODO: Navigate to level
                print('Selected level: ${level.name}');
              }
            : null,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildIcon(isActive),
              const SizedBox(width: 16),
              Expanded(
                child: _buildLevelInfo(isActive),
              ),
              if (isActive && !level.isCompleted) _buildPlayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(bool isActive) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: isActive ? level.color.withOpacity(0.1) : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: level.isCompleted
          ? Icon(
              Icons.check_circle_rounded,
              color: level.color,
              size: 36,
            )
          : Icon(
              level.icon,
              color: isActive ? level.color : Colors.grey[400],
              size: 36,
            ),
    );
  }

  Widget _buildLevelInfo(bool isActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: level.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Level ${level.id}',
                style: AppTheme.childBodyText.copyWith(
                  color: level.color,
                  fontSize: 12,
                ),
              ),
            ),
            if (level.isCompleted) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.star,
                color: AppTheme.childYellow,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '5',
                style: AppTheme.childBodyText.copyWith(
                  color: AppTheme.childYellow,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          level.name,
          style: AppTheme.childTitleLarge.copyWith(
            color: isActive ? AppTheme.childTurquoise : Colors.grey[400],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          level.description,
          style: AppTheme.childBodyText.copyWith(
            color: isActive
                ? AppTheme.childTurquoise.withOpacity(0.7)
                : Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayButton() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: level.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        Icons.play_arrow_rounded,
        color: level.color,
        size: 32,
      ),
    );
  }
}
