// lib/screens/onboarding_screens/welcome/components/welcome_screen1.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'screen_template.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScreenTemplate(
      title: 'Welcome to MultiTalk AAC',
      subtitle: 'Your Early Support Companion',
      illustration: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryBrown.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.child_care,
            size: 100,
            color: AppTheme.accentGreen,
          ),
        ),
      ),
      description:
          'Supporting parents and children in their early development journey with expert-guided activities and tools.',
    );
  }
}
