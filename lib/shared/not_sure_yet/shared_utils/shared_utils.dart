// lib/shared/utils/app_utils.dart

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
}
