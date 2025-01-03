import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import '../dialogs/password_prompt_dialog.dart';
import '../dialogs/remove_confirmation_dialog.dart';
import '../dialogs/single_profile_warning_dialog.dart';

class EditProfileService {
  final BuildContext context;
  final String profileId;
  final VoidCallback onSuccess;

  EditProfileService({
    required this.context,
    required this.profileId,
    required this.onSuccess,
  });

  Future<void> updateProfile({
    required String name,
    required bool textToSpeechEnabled,
  }) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) throw Exception('No user logged in');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('children')
        .doc(profileId)
        .update({
      'name': name,
      'textToSpeechEnabled': textToSpeechEnabled,
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: AppTheme.accentGreen,
        ),
      );
      onSuccess();
    }
  }

  Future<void> initiateProfileRemoval() async {
    // Check if this is the only profile
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final profilesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('children')
        .get();

    if (profilesSnapshot.size <= 1) {
      if (context.mounted) {
        await showSingleProfileWarningDialog(context);
      }
      return;
    }

    // Continue with normal removal process if there are multiple profiles
    if (context.mounted) {
      final passwordConfirmed = await showPasswordPromptDialog(context);
      if (passwordConfirmed != true) return;

      if (context.mounted) {
        final removeConfirmed = await showRemoveConfirmationDialog(context);
        if (removeConfirmed == true) {
          await _removeProfile();
        }
      }
    }
  }

  Future<void> _removeProfile() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception('No user logged in');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('children')
          .doc(profileId)
          .delete();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile removed successfully'),
            backgroundColor: AppTheme.accentGreen,
          ),
        );
        onSuccess();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to remove profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
