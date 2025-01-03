import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/child_name/child_name_input.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_dashboard_screens/settings_screens/child_profile_screen/edit_child_profile.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/models/parents_models/child_profile.dart';

enum ProfileView {
  list,
  edit,
  grid,
}

class ChildProfileWrapper extends StatefulWidget {
  const ChildProfileWrapper({super.key});

  @override
  State<ChildProfileWrapper> createState() => _ChildProfileWrapperState();
}

class _ChildProfileWrapperState extends State<ChildProfileWrapper> {
  ProfileView _currentView = ProfileView.list;
  ChildProfile? _selectedProfile;

  // Reference to Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  late Stream<QuerySnapshot> _profilesStream;

  @override
  void initState() {
    super.initState();
    _initializeProfilesStream();
  }

  void _initializeProfilesStream() {
    if (_userId != null) {
      _profilesStream = _firestore
          .collection('users')
          .doc(_userId)
          .collection('children')
          .snapshots();
    }
  }

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
    return StreamBuilder<QuerySnapshot>(
      stream: _profilesStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading profiles',
              style: AppTheme.bodyLarge.copyWith(color: Colors.red),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.accentGreen),
          );
        }

        final profiles = snapshot.data?.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return ChildProfile(
                id: doc.id,
                name: data['name'] ?? 'Unnamed Child',
                textToSpeechEnabled: data['textToSpeechEnabled'] ?? true,
              );
            }).toList() ??
            [];

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Profiles',
              style: AppTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (profiles.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'No profiles added yet',
                    style: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.secondaryBrown,
                    ),
                  ),
                ),
              )
            else
              ...profiles.map((profile) => _buildProfileCard(profile)),
            const SizedBox(height: 16),
            _buildAddNewProfileButton(),
          ],
        );
      },
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
