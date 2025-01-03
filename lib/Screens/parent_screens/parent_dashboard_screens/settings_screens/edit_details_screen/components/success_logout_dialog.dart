import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/sign_in_up/sign_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';

void showSuccessLogoutDialog(BuildContext context, String newEmail) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Email Change Initiated',
          style: AppTheme.headingMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'A verification email has been sent to $newEmail. Please verify your new email address to complete the change.',
              style: AppTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'You will be logged out now. After verifying, please log in with your new email.',
              style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: AppTheme.primaryButtonStyle,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const SignParent(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
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
