import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ScheduleStyleHelper {
  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'learn':
        return Icons.school;
      case 'play':
        return Icons.sports_esports;
      case 'sleep':
        return Icons.bedtime;
      case 'eat':
        return Icons.restaurant;
      case 'bath':
        return Icons.bathtub;
      case 'exercise':
        return Icons.fitness_center;
      case 'medicine':
        return Icons.medication;
      case 'dress':
        return Icons.checkroom;
      default:
        return Icons.event_note;
    }
  }

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'learn':
        return AppTheme.childTurquoise;
      case 'play':
        return AppTheme.childPink;
      case 'sleep':
        return AppTheme.childPurple;
      case 'eat':
        return AppTheme.childOrange;
      case 'bath':
        return AppTheme.childSoftGreen;
      default:
        return AppTheme.childTurquoise;
    }
  }
}
