// lib/screens/parent_screens/settings_screens/edit_details/helpers/edit_details_helpers.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class EditDetailsHelpers {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value != null && value.isNotEmpty && value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String getErrorMessage(String code) {
    switch (code) {
      case 'requires-recent-login':
        return 'Please sign in again to change these settings';
      case 'invalid-email':
        return 'Please enter a valid email address';
      case 'email-already-in-use':
        return 'This email is already in use';
      case 'weak-password':
        return 'Password must be at least 6 characters';
      default:
        return 'Failed to update profile';
    }
  }

  void showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTheme.bodyMedium.copyWith(color: Colors.white),
        ),
        backgroundColor: AppTheme.accentGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget buildErrorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        message,
        style: AppTheme.bodyMedium.copyWith(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }
}
