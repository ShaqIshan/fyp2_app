import 'package:flutter/material.dart';
import 'package:fyp2_app/models/child_profile.dart';
import 'package:fyp2_app/shared/app_theme.dart';

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
  late TextEditingController _nameController;
  late bool _textToSpeechEnabled;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing profile data
    _nameController = TextEditingController(text: widget.profile.name);
    _textToSpeechEnabled = widget.profile.textToSpeechEnabled;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    // Print collected data (for now)
    print('\n--- Child Profile Update ---');
    print('Profile ID: ${widget.profile.id}');
    print('Name: ${_nameController.text}');
    print('Text-to-Speech: $_textToSpeechEnabled');
    print('-------------------------\n');

    // TODO: Implement state management
    // Will update profile data using a state management solution
    // Example: context.read<ChildProfileProvider>().updateProfile(updatedProfile);

    widget.onBack();
  }

  void _showRemoveProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Remove Profile',
          style: AppTheme.headingMedium,
        ),
        content: Text(
          'Are you sure you want to remove this profile? This action cannot be undone.',
          style: AppTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.secondaryBrown,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement profile removal with state management
              print('Removing profile: ${widget.profile.id}');
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to profile list
            },
            child: Text(
              'Remove',
              style: AppTheme.titleMedium.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection(
            title: 'Profile Name',
            child: TextFormField(
              controller: _nameController,
              decoration: AppTheme.getInputDecoration(
                hint: 'Enter profile name',
                icon: Icons.person_outline,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
          ),
          _buildSection(
            title: 'Communication Board',
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Text-to-Speech',
                    style: AppTheme.bodyLarge,
                  ),
                  value: _textToSpeechEnabled,
                  onChanged: (value) {
                    setState(() {
                      _textToSpeechEnabled = value;
                    });
                  },
                  activeColor: AppTheme.accentGreen,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Communication Board Grid',
                    style: AppTheme.bodyLarge,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppTheme.secondaryBrown,
                  ),
                  onTap: () {
                    // TODO: Navigate to grid settings using wrapper
                    print('Navigate to grid settings');
                  },
                ),
              ],
            ),
          ),
          _buildSection(
            title: 'Remove Profile',
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Remove Profile',
                style: AppTheme.bodyLarge.copyWith(
                  color: Colors.red,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.red,
              ),
              onTap: _showRemoveProfileDialog,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: widget.onBack,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppTheme.buttonTextStyle.copyWith(
                      color: AppTheme.secondaryBrown,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: AppTheme.primaryButtonStyle,
                  child: const Text(
                    'Save Changes',
                    style: AppTheme.buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        child,
        const SizedBox(height: 24),
      ],
    );
  }
}
