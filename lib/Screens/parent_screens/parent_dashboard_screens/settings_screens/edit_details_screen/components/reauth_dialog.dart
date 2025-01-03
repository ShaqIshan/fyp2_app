import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/shared/app_theme.dart';

Future<bool> showReauthDialog(
  BuildContext context,
  TextEditingController passwordController,
  FirebaseAuth auth,
) async {
  bool success = false;
  bool showPassword = false;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text(
              'Confirm Your Password',
              style: AppTheme.headingMedium,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'For security reasons, please enter your current password to make these changes.',
                  style: AppTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    hintText: 'Current Password',
                    hintStyle: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textDark.withOpacity(0.5),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppTheme.secondaryBrown,
                      ),
                      onPressed: () {
                        setStateDialog(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: AppTheme.defaultBorder,
                    enabledBorder: AppTheme.defaultBorder,
                    focusedBorder: AppTheme.focusedBorder,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  success = false;
                },
                child: Text(
                  'Cancel',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = auth.currentUser;
                    if (user != null) {
                      final credential = EmailAuthProvider.credential(
                        email: user.email!,
                        password: passwordController.text,
                      );
                      await user.reauthenticateWithCredential(credential);
                      success = true;
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    success = false;
                    Navigator.of(context).pop();
                  }
                },
                style: AppTheme.primaryButtonStyle,
                child: const Text(
                  'Confirm',
                  style: AppTheme.buttonTextStyle,
                ),
              ),
            ],
          );
        },
      );
    },
  );

  return success;
}
