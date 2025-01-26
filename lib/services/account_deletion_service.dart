// lib/services/account_deletion_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class AccountDeletionService {
  final BuildContext context;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AccountDeletionService(this.context);

  Future<void> initiateAccountDeletion() async {
    final confirmed = await showDeleteConfirmationDialog();
    if (confirmed != true) return;

    final reauthenticated = await _reAuthenticateUser();
    if (reauthenticated != true) return;

    try {
      await _deleteUserData();
      await _deleteUserAccount();

      if (context.mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(e.toString());
      }
    }
  }

  Future<bool> showDeleteConfirmationDialog() async {
    bool? result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Account',
            style: AppTheme.headingMedium.copyWith(color: Colors.red),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to delete your account? This action cannot be undone.',
                style: AppTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'This will permanently delete:',
                style:
                    AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '• Your account and login credentials\n• All child profiles\n• All associated data and settings',
                style: AppTheme.bodyMedium,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
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
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete Account'),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  Future<bool> _reAuthenticateUser() async {
    final passwordController = TextEditingController();
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
                    'Please enter your password to delete your account.',
                    style: AppTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppTheme.secondaryBrown,
                        ),
                        onPressed: () {
                          setStateDialog(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      border: AppTheme.defaultBorder,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
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
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    try {
                      final user = _auth.currentUser;
                      if (user?.email != null) {
                        final credential = EmailAuthProvider.credential(
                          email: user!.email!,
                          password: passwordController.text,
                        );
                        await user.reauthenticateWithCredential(credential);
                        success = true;
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );

    return success;
  }

  Future<void> _deleteUserData() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    // Delete all child profiles
    final childrenSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('children')
        .get();

    for (var doc in childrenSnapshot.docs) {
      await doc.reference.delete();
    }

    // Delete user document
    await _firestore.collection('users').doc(userId).delete();
  }

  Future<void> _deleteUserAccount() async {
    await _auth.currentUser?.delete();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Account Deleted',
            style: AppTheme.headingMedium,
          ),
          content: Text(
            'Your account has been successfully deleted. You will now be redirected to the welcome page.',
            style: AppTheme.bodyMedium,
          ),
          actions: [
            ElevatedButton(
              style: AppTheme.primaryButtonStyle,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: AppTheme.headingMedium.copyWith(color: Colors.red),
          ),
          content: Text(
            'Failed to delete account: $error',
            style: AppTheme.bodyMedium,
          ),
          actions: [
            ElevatedButton(
              style: AppTheme.primaryButtonStyle,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
