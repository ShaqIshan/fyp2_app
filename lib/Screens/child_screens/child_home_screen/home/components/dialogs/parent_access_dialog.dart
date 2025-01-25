// lib/screens/child/home/components/dialogs/parent_access_dialog.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/screens/parent_screens/parent_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ParentAccessDialog extends StatefulWidget {
  const ParentAccessDialog({super.key});

  @override
  State<ParentAccessDialog> createState() => _ParentAccessDialogState();
}

class _ParentAccessDialogState extends State<ParentAccessDialog> {
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String? _errorText;
  bool _isLoading = false;

  Future<void> _handleSubmit(BuildContext context) async {
    if (_passwordController.text.isEmpty) {
      setState(() {
        _errorText = "Please enter your password";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null || currentUser.email == null) {
        setState(() {
          _errorText = "Unable to verify credentials";
          _isLoading = false;
        });
        return;
      }

      final credential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password: _passwordController.text,
      );

      await currentUser.reauthenticateWithCredential(credential);

      if (mounted) {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ParentWrapper()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'wrong-password':
            _errorText = "Incorrect password";
            break;
          case 'too-many-requests':
            _errorText = "Too many attempts. Please try again later";
            break;
          default:
            _errorText = "Authentication failed";
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorText = "An error occurred";
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'Parent Access',
        style: AppTheme.childHeadingMedium.copyWith(
          color: AppTheme.childTurquoise,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            enabled: !_isLoading,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              errorText: _errorText,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: AppTheme.childTurquoise,
                ),
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.childTurquoise,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.childTurquoise,
                  width: 2,
                ),
              ),
            ),
            onSubmitted: _isLoading ? null : (_) => _handleSubmit(context),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed:
                    _isLoading ? null : () => Navigator.of(context).pop(),
                child: Text(
                  'Cancel',
                  style: AppTheme.childBodyText.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isLoading ? null : () => _handleSubmit(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.childTurquoise,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Submit',
                        style: AppTheme.childBodyText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
