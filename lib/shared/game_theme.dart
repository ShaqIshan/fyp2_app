// lib/shared/game_theme.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class GameTheme {
  static const double cardHeight = 240.0;
  static const double iconSize = 48.0;
  static const double borderRadius = 24.0;

  static BoxDecoration gameCardDecoration({
    required Color baseColor,
    bool isLocked = false,
  }) {
    return BoxDecoration(
      color: baseColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: baseColor.withOpacity(0.3),
        width: 4,
      ),
      boxShadow: [
        BoxShadow(
          color: baseColor.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static TextStyle gameTitleStyle = AppTheme.childHeadingMedium.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle gameDescriptionStyle = AppTheme.childBodyText.copyWith(
    fontSize: 16,
    color: Colors.black54,
  );

  static BoxDecoration difficultyBadgeDecoration({required Color color}) {
    return BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
