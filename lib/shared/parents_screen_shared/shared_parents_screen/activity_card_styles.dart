// lib/shared/activity_styles.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ActivityStyles {
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration badgeDecoration({Color? color}) => BoxDecoration(
        color: (color ?? AppTheme.secondaryBrown).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      );

  static BoxDecoration headerGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppTheme.primaryBrown,
        AppTheme.primaryBrown.withOpacity(0.8),
      ],
    ),
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(32),
      bottomRight: Radius.circular(32),
    ),
  );

  static ButtonStyle scheduleButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
