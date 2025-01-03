import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

Future<void> showSingleProfileWarningDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Cannot Remove Profile',
          style: AppTheme.headingMedium.copyWith(
            color: Colors.red,
          ),
        ),
        content: Text(
          'You must have at least one child profile. Add another profile before removing this one.',
          style: AppTheme.bodyMedium,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: AppTheme.buttonTextStyle,
            ),
          ),
        ],
      );
    },
  );
}
