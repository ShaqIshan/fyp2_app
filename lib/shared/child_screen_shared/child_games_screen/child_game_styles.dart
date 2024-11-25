import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ChildGameStyles {
  static BoxDecoration headerDecoration = BoxDecoration(
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
  );

  static BoxDecoration cardDecoration(Color backgroundColor) => BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration categoryBadgeDecoration(Color backgroundColor) =>
      BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      );

  static BoxDecoration starCounterDecoration = BoxDecoration(
    color: AppTheme.childYellow.withOpacity(0.2),
    borderRadius: BorderRadius.circular(20),
  );
}
