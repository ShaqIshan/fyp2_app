import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

Future<bool> showEmailChangeWarning(
    BuildContext context, String newEmail) async {
  bool proceed = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Important Notice',
          style: AppTheme.headingMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You are about to change your email to:',
              style: AppTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              newEmail,
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.accentGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Please note:',
              style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '• You will be logged out automatically\n• You will need to verify the new email\n• You can only log in with the new email after verification',
              style: AppTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              proceed = false;
            },
            child: Text(
              'Cancel',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.secondaryBrown,
              ),
            ),
          ),
          ElevatedButton(
            style: AppTheme.primaryButtonStyle,
            onPressed: () {
              Navigator.of(context).pop();
              proceed = true;
            },
            child: const Text(
              'Continue',
              style: AppTheme.buttonTextStyle,
            ),
          ),
        ],
      );
    },
  );
  return proceed;
}
