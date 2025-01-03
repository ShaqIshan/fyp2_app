// lib/screens/parent_screens/settings_screens/child_profile/edit_profile.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/models/parents_models/child_profile.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'components/profile_name_section.dart';
import 'components/communication_section.dart';
import 'components/remove_section.dart';
import 'components/save_button.dart';
import 'services/edit_profile_service.dart';

class EditChildProfile extends StatefulWidget {
  final ChildProfile profile;
  final VoidCallback onBack;

  const EditChildProfile({
    super.key,
    required this.profile,
    required this.onBack,
  });

  @override
  State<EditChildProfile> createState() => _EditChildProfileState();
}

class _EditChildProfileState extends State<EditChildProfile> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  late TextEditingController _nameController;
  late bool _textToSpeechEnabled;
  String? _errorMessage;
  bool _isLoading = false;

  late final EditProfileService _profileService;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _textToSpeechEnabled = widget.profile.textToSpeechEnabled;
    _profileService = EditProfileService(
      context: context,
      profileId: widget.profile.id,
      onSuccess: widget.onBack,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _profileService.updateProfile(
        name: _nameController.text.trim(),
        textToSpeechEnabled: _textToSpeechEnabled,
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update profile';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileNameSection(controller: _nameController),
              const SizedBox(height: 24),
              CommunicationSection(
                textToSpeechEnabled: _textToSpeechEnabled,
                onTextToSpeechChanged: (value) {
                  setState(() {
                    _textToSpeechEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              RemoveSection(
                profileName: widget.profile.name,
                onRemove: () => _profileService.initiateProfileRemoval(),
              ),
              const SizedBox(height: 32),
              SaveButton(
                isLoading: _isLoading,
                onSave: _saveChanges,
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _errorMessage!,
                    style: AppTheme.bodyMedium.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
