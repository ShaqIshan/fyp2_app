import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/shared/app_theme.dart';

Future<bool> showPasswordPromptDialog(BuildContext context) async {
  final passwordController = TextEditingController();
  bool showPassword = false;
  bool isAuthenticated = false;

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Confirm Password',
          style: AppTheme.headingMedium.copyWith(
            color: AppTheme.primaryBrown,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please enter your password to remove this profile',
                  style: AppTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppTheme.secondaryBrown.withOpacity(0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppTheme.secondaryBrown.withOpacity(0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppTheme.accentGreen,
                        width: 2,
                      ),
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
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.secondaryBrown,
              ),
            ),
          ),
          ElevatedButton(
            style: AppTheme.primaryButtonStyle,
            onPressed: () async {
              try {
                final user = FirebaseAuth.instance.currentUser;
                if (user?.email != null) {
                  final credential = EmailAuthProvider.credential(
                    email: user!.email!,
                    password: passwordController.text,
                  );
                  await user.reauthenticateWithCredential(credential);
                  isAuthenticated = true;
                  Navigator.pop(context);
                }
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.code == 'wrong-password'
                          ? 'Incorrect password'
                          : 'Authentication failed',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              'Confirm',
              style: AppTheme.buttonTextStyle,
            ),
          ),
        ],
      );
    },
  );

  return isAuthenticated;
}
