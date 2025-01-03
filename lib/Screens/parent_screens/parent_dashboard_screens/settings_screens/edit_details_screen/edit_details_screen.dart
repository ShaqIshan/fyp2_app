// lib/screens/parent_screens/settings_screens/edit_details/edit_details_screen.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/parents_screen_shared/settings_edit_details/form_widgets.dart';
import 'components/email_change_warning.dart';
import 'components/reauth_dialog.dart';
import 'components/success_logout_dialog.dart';
import 'helpers/edit_details_helpers.dart';

class EditDetailsScreen extends StatefulWidget {
  const EditDetailsScreen({super.key});

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _helpers = EditDetailsHelpers();

  bool _showPassword = false;
  String? _errorMessage;
  bool _loading = false;
  String? _newEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    setState(() {
      _emailController.text = _auth.currentUser?.email ?? '';
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      bool isChangingEmail = _emailController.text.trim() != user.email;
      bool isChangingPassword = _passwordController.text.isNotEmpty;

      // Show email change warning if needed
      if (isChangingEmail) {
        final proceedWithEmailChange = await showEmailChangeWarning(
          context,
          _emailController.text.trim(),
        );
        if (!proceedWithEmailChange) {
          setState(() => _loading = false);
          return;
        }
      }

      // Reauthenticate for sensitive changes
      if (isChangingEmail || isChangingPassword) {
        final success = await showReauthDialog(
          context,
          _currentPasswordController,
          _auth,
        );
        if (!success) {
          setState(() {
            _errorMessage = 'Invalid password. Please try again.';
            _loading = false;
          });
          return;
        }
      }

      // Handle password change first if only changing password
      if (isChangingPassword && !isChangingEmail) {
        await user.updatePassword(_passwordController.text);
        if (mounted) {
          _helpers.showSuccessMessage(context, 'Password updated successfully');
          Navigator.pop(context);
          return;
        }
      }

      // Handle email change (and password change if both are being changed)
      if (isChangingEmail) {
        _newEmail = _emailController.text.trim();

        // Update password first if also changing it
        if (isChangingPassword) {
          await user.updatePassword(_passwordController.text);
        }

        await user.verifyBeforeUpdateEmail(_emailController.text.trim());
        if (mounted) {
          showSuccessLogoutDialog(context, _newEmail!);
        }
        return;
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = _helpers.getErrorMessage(e.code);
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred';
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
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              if (_errorMessage != null)
                _helpers.buildErrorMessage(_errorMessage!),
              const SizedBox(height: 32),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return FormWidgets.buildFormField(
      label: 'Email',
      controller: _emailController,
      hint: 'Enter your email',
      icon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: _helpers.validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return StatefulBuilder(
      builder: (context, setStateLocal) {
        return FormWidgets.buildFormField(
          label: 'Password',
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
              setStateLocal(() {
                _showPassword = !_showPassword;
              });
            },
          ),
          validator: _helpers.validatePassword,
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _loading ? null : _saveChanges,
        style: AppTheme.primaryButtonStyle,
        child: _loading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Save Changes', style: AppTheme.buttonTextStyle),
      ),
    );
  }
}
