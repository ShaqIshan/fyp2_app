import 'package:flutter/material.dart';

import '../../../../../../shared/app_theme.dart';

Future<bool?> showRemoveConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Remove Profile',
          style: AppTheme.headingMedium.copyWith(
            color: Colors.red,
          ),
        ),
        content: Text(
          'Are you sure you want to remove this profile? This action cannot be undone.',
          style: AppTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.secondaryBrown,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Remove',
              style: AppTheme.buttonTextStyle,
            ),
          ),
        ],
      );
    },
  );
}
