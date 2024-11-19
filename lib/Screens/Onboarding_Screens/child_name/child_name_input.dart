import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/assess_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ChildNameInput extends StatefulWidget {
  final bool isFromProfileManagement;

  const ChildNameInput({
    super.key,
    this.isFromProfileManagement = false,
  });

  @override
  State<ChildNameInput> createState() => _ChildNameInputState();
}

class _ChildNameInputState extends State<ChildNameInput> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasError = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _proceedToAssessment(BuildContext context, String name) {
    // TODO: Use state management to store child name

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AssessWrapper(
          childName: name,
          isFromProfileManagement: widget.isFromProfileManagement,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: widget.isFromProfileManagement
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppTheme.primaryBrown,
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                Text(
                  'What\'s your child\'s name?',
                  style: AppTheme.headingLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'This helps us personalize their experience',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.secondaryBrown,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter child\'s name',
                    hintStyle: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.secondaryBrown.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: AppTheme.defaultBorder,
                    enabledBorder: AppTheme.defaultBorder,
                    focusedBorder: AppTheme.focusedBorder,
                    errorBorder: AppTheme.defaultBorder.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: AppTheme.defaultBorder.copyWith(
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    errorStyle: AppTheme.bodyMedium.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  style: AppTheme.bodyLarge,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your child\'s name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (_hasError) {
                      _formKey.currentState?.validate();
                    }
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        _proceedToAssessment(
                          context,
                          _nameController.text.trim(),
                        );
                      }
                    },
                    style: AppTheme.primaryButtonStyle,
                    child: const Text(
                      'Next',
                      style: AppTheme.buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
