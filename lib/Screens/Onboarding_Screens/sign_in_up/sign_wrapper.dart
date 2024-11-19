import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/sign_in_up/sign_in.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/sign_in_up/sign_up.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class SignParent extends StatefulWidget {
  const SignParent({super.key});

  @override
  State<SignParent> createState() => _SignParentState();
}

class _SignParentState extends State<SignParent> {
  bool isSignUpForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // sign up screen
              if (isSignUpForm)
                Column(
                  children: [
                    const SignUp(),
                    const SizedBox(height: 24),
                    _buildAccountSwitcher(),
                  ],
                ),

              // sign in screen
              if (!isSignUpForm)
                Column(
                  children: [
                    const SignIn(),
                    const SizedBox(height: 24),
                    _buildAccountSwitcher(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSwitcher() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.secondaryBrown.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.secondaryBrown.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          Text(
            isSignUpForm ? 'Already have an account?' : 'Need an account?',
            style: AppTheme.bodyMedium,
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              setState(() {
                isSignUpForm = !isSignUpForm;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.accentGreen,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: AppTheme.accentGreen.withOpacity(0.1),
            ),
            child: Text(
              isSignUpForm ? 'Sign in Instead' : 'Sign up Instead',
              style: AppTheme.modifyStyle(
                AppTheme.bodyMedium,
                fontWeight: FontWeight.w600,
                color: AppTheme.accentGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
