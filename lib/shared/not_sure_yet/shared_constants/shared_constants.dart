// lib/shared/constants/app_constants.dart

class AppConstants {
  // Layout constants
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;
  static const double defaultRadius = 12.0;
  static const double defaultSpacing = 8.0;

  // Component sizes
  static const double bottomNavHeight = 80.0;
  static const double bottomNavIconSize = 24.0;
  static const double iconSize = 24.0;
  static const double cardElevation = 4.0;

  // Animation durations
  static const Duration defaultDuration = Duration(milliseconds: 300);
  static const Duration shortDuration = Duration(milliseconds: 150);

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 30;

  // Assessment
  static const int totalAssessmentQuestions = 6;
  static const int minQuestionsRequired = 4;

  // Schedule
  static const int maxDailyActivities = 8;
  static const int defaultActivityDuration = 30; // in minutes

  // Grid
  static const int gridCrossAxisCount = 2;
  static const double gridAspectRatio = 1.5;
}
