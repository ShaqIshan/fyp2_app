// lib/screens/settings/settings_wrapper.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_dashboard_screens/settings_screens/child_profile_screen/child_profile_wrapper.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_dashboard_screens/settings_screens/edit_details_screen.dart';
import 'package:fyp2_app/services/auth_service.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class SettingsWrapper extends StatelessWidget {
  final VoidCallback onBackPressed;

  const SettingsWrapper({
    super.key,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppTheme.primaryBrown,
          ),
          onPressed: onBackPressed,
        ),
        title: Text(
          'Settings',
          style: AppTheme.headingMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Account Settings'),
              _buildSettingsItem(
                'Edit Personal Details',
                Icons.person_outline,
                onTap: () {
                  // TODO: Navigate to edit personal details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditDetailsScreen()),
                  );
                },
              ),
              _buildSettingsItem(
                'Child Profile Management',
                Icons.child_care_outlined,
                onTap: () {
                  // TODO: Navigate to child profile management screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChildProfileWrapper()),
                  );
                },
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('App Preferences'),
              _buildLanguageSelector(),
              const SizedBox(height: 24),

              _buildSectionTitle('Data Management'),
              _buildSettingsItem(
                'Export Data',
                Icons.download_outlined,
                onTap: () {
                  // TODO: Handle data export
                },
              ),
              _buildSettingsItem(
                'Delete Account',
                Icons.delete_outline,
                textColor: Colors.red,
                onTap: () {
                  // TODO: Show delete account confirmation
                },
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('App Information'),
              _buildInfoItem('Version', '1.2.5'),
              const SizedBox(height: 40),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthService.signOut();
                    // Note: No navigation needed as auth provider will handle redirect

                    Navigator.pop(context); // goes back to login page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: AppTheme.buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: AppTheme.titleLarge.copyWith(
          color: AppTheme.primaryBrown,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon, {
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: textColor ?? AppTheme.secondaryBrown,
      ),
      title: Text(
        title,
        style: AppTheme.bodyLarge.copyWith(
          color: textColor ?? AppTheme.textDark,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppTheme.secondaryBrown,
      ),
      onTap: onTap,
    );
  }

  Widget _buildLanguageSelector() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(
        Icons.language,
        color: AppTheme.secondaryBrown,
      ),
      title: Text(
        'Language',
        style: AppTheme.bodyLarge.copyWith(
          color: AppTheme.textDark,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'English',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.secondaryBrown,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppTheme.secondaryBrown,
          ),
        ],
      ),
      onTap: () {
        // TODO: Show language selection dialog/screen
      },
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: AppTheme.bodyLarge.copyWith(
          color: AppTheme.textDark,
        ),
      ),
      trailing: Text(
        value,
        style: AppTheme.bodyMedium.copyWith(
          color: AppTheme.secondaryBrown,
        ),
      ),
    );
  }
}
