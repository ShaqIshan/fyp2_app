// lib/shared/utils/app_utils.dart

import 'package:fyp2_app/models/not_sure_yet/activity_category.dart';
import 'package:fyp2_app/models/not_sure_yet/assessment_level.dart';
import 'package:fyp2_app/shared/not_sure_yet/shared_constants/shared_constants.dart';
import 'package:intl/intl.dart';

class AppUtils {
  // Date and Time formatting
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String formatDateWithDay(DateTime date) {
    return DateFormat('EEEE, dd MMM yyyy').format(date);
  }

  // Basic text formatting
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  // Validation helpers
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= AppConstants.minPasswordLength;
  }

  // Assessment helper
  static AssessmentLevel calculateAssessmentLevel(List<String> answers) {
    // This is a simple example - you'll want to implement your actual assessment logic
    int score = 0;

    for (String answer in answers) {
      if (answer.toLowerCase().contains('yes')) score++;
      if (answer.toLowerCase().contains('often')) score += 2;
    }

    if (score <= 3) return AssessmentLevel.needsSupport;
    if (score <= 6) return AssessmentLevel.needsSubstantialSupport;
    return AssessmentLevel.needsVerySubstantialSupport;
  }

  // Activity category helper
  static String getCategoryDisplayName(ActivityCategory category) {
    switch (category) {
      case ActivityCategory.aacSupport:
        return 'AAC Support';
      case ActivityCategory.languageDevelopment:
        return 'Language Development';
      case ActivityCategory.soundProduction:
        return 'Sound Production';
      case ActivityCategory.socialCommunication:
        return 'Social Communication';
      case ActivityCategory.conversationSkills:
        return 'Conversation Skills';
    }
  }
}
