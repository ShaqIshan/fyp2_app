// lib/screens/parent_screens/settings/edit_details_screen.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/settings_edit_details/form_widgets.dart';

class EditDetailsScreen extends StatefulWidget {
  const EditDetailsScreen({super.key});

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;
  String? _errorMessage;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Mock initial data
    _firstNameController.text = 'Steve';
    _lastNameController.text = 'Brown';
    _emailController.text = 'stevebrown@gmail.com';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      // Print all form data
      print('\n--- Personal Details Update ---');
      print('First Name: ${_firstNameController.text.trim()}');
      print('Last Name: ${_lastNameController.text.trim()}');
      print('Email: ${_emailController.text.trim()}');
      if (_passwordController.text.isNotEmpty) {
        print(
            'New Password Set: Yes (${_passwordController.text.length} characters)');
      } else {
        print('New Password Set: No');
      }
      print('----------------------------\n');

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile details printed to console',
              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
            ),
            backgroundColor: AppTheme.accentGreen,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print('Error saving changes: $e');
      setState(() {
        _errorMessage = 'Failed to save changes. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primaryBrown),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Personal Details',
          style: AppTheme.headingMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormWidgets.buildFormField(
                label: 'First name',
                controller: _firstNameController,
                hint: 'Enter your first name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              FormWidgets.buildFormField(
                label: 'Last name',
                controller: _lastNameController,
                hint: 'Enter your last name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              FormWidgets.buildFormField(
                label: 'Email',
                controller: _emailController,
                hint: 'Enter your email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              FormWidgets.buildFormField(
                label: 'New Password (optional)',
                controller: _passwordController,
                hint: 'Enter new password',
                icon: Icons.lock_outline,
                obscureText: !_showPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                    color: AppTheme.secondaryBrown,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              if (_errorMessage != null)
                FormWidgets.buildErrorMessage(_errorMessage!),
              const SizedBox(height: 16),
              FormWidgets.buildSubmitButton(
                text: 'Save Changes',
                onPressed: _saveChanges,
                isLoading: _loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
