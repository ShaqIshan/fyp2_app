// lib/screens/onboarding_screens/child_name/child_name_input.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/screens/parent_screens/parent_wrapper.dart';
import 'package:fyp2_app/services/child_service.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ChildNameInput extends StatefulWidget {
  final bool isFromDashboard;
  final bool isFromProfileManagement;

  const ChildNameInput({
    super.key,
    this.isFromDashboard = false,
    this.isFromProfileManagement = false,
  });

  @override
  State<ChildNameInput> createState() => _ChildNameInputState();
}

class _ChildNameInputState extends State<ChildNameInput> {
  final TextEditingController _nameController = TextEditingController();
  final ChildService _childService = ChildService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleSubmit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a name';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Save to Firebase
      final childId = await _childService.addChild(name);

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully added ${_nameController.text}',
              style: AppTheme.bodyMedium.copyWith(color: Colors.white),
            ),
            backgroundColor: AppTheme.accentGreen,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate based on where we came from
        if (widget.isFromProfileManagement) {
          Navigator.pop(context);
        } else if (widget.isFromDashboard) {
          Navigator.pop(context);
        } else {
          // This is from initial registration - navigate to parent dashboard
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ParentWrapper(),
            ),
            (route) => false, // This removes all previous routes from the stack
          );
        }
      }
    } catch (e) {
      print('Error saving child profile: $e');
      setState(() {
        _errorMessage = 'Failed to save child profile: ${e.toString()}';
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
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: widget.isFromDashboard || widget.isFromProfileManagement
            ? IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: AppTheme.primaryBrown),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's your child's name?",
              style: AppTheme.displayLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'This helps us personalize their experience',
              style:
                  AppTheme.bodyLarge.copyWith(color: AppTheme.secondaryBrown),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nameController,
              decoration: AppTheme.getInputDecoration(
                hint: "Enter child's name",
                icon: Icons.person_outline,
                errorText: _errorMessage,
              ),
              style: AppTheme.bodyLarge,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) {
                if (_errorMessage != null) {
                  setState(() {
                    _errorMessage = null;
                  });
                }
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: AppTheme.primaryButtonStyle,
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'Continue',
                        style: AppTheme.buttonTextStyle,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
