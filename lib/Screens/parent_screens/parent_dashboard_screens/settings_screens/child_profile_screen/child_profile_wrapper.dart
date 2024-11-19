import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/child_name/child_name_input.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/assess_wrapper.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_dashboard_screens/parent_dashboard.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_dashboard_screens/settings_screens/child_profile_screen/edit_child_profile.dart';
import 'package:fyp2_app/models/child_profile.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_dashboard_screens/settings_screens/edit_details_screen.dart';

enum ProfileView {
  list,
  edit,
  grid, // For future communication board grid settings
}

class ChildProfileWrapper extends StatefulWidget {
  const ChildProfileWrapper({super.key});

  @override
  State<ChildProfileWrapper> createState() => _ChildProfileWrapperState();
}

class _ChildProfileWrapperState extends State<ChildProfileWrapper> {
  ProfileView _currentView = ProfileView.list;
  ChildProfile? _selectedProfile;

  // Mock data - Replace with state management later
  final List<ChildProfile> _profiles = [
    ChildProfile(
      id: '1',
      name: 'Sophia',
      speechDelayLevel: 'Mild speech delay',
      textToSpeechEnabled: true,
    ),
    ChildProfile(
      id: '2',
      name: 'Robert',
      speechDelayLevel: 'Moderate speech delay',
      textToSpeechEnabled: true,
    ),
  ];

  void _editProfile(ChildProfile profile) {
    setState(() {
      _selectedProfile = profile;
      _currentView = ProfileView.edit;
    });
  }

  void _returnToList() {
    setState(() {
      _currentView = ProfileView.list;
      _selectedProfile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Common app bar for all views
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.primaryBrown),
        onPressed: _currentView == ProfileView.list
            ? () => Navigator.pop(context)
            : _returnToList,
      ),
      title: Text(
        _currentView == ProfileView.list
            ? 'Child Profile Management'
            : 'Edit Profile',
        style: AppTheme.headingMedium,
      ),
    );

    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: appBar,
      body: _currentView == ProfileView.list
          ? _buildProfileList()
          : EditChildProfile(
              profile: _selectedProfile!,
              onBack: _returnToList,
            ),
    );
  }

  Widget _buildProfileList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Profiles',
          style: AppTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ..._profiles.map((profile) => _buildProfileCard(profile)),
        _buildAddNewProfileButton(),
      ],
    );
  }

  Widget _buildProfileCard(ChildProfile profile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: AppTheme.titleMedium,
                ),
                Text(
                  profile.speechDelayLevel,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _editProfile(profile),
            style: TextButton.styleFrom(
              backgroundColor: AppTheme.accentGreen.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Edit',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.accentGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewProfileButton() {
    return InkWell(
      onTap: () {
        // Navigate to child name input with back button
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChildNameInput(
              isFromProfileManagement: true,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.accentGreen.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle_outline,
              color: AppTheme.accentGreen,
            ),
            const SizedBox(width: 8),
            Text(
              'Add New Profile',
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.accentGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
