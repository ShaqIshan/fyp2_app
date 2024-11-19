import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/sign_in_up/sign_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/shared_welcome_screen/custom_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This creates a provider that stores a boolean value
final isAuthFlowProvider = StateProvider<bool>((ref) => false);

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the auth flow state
    final bool isInAuthFlow = ref.watch(isAuthFlowProvider);

    // If we're in the auth flow, show the SignParent screen
    if (isInAuthFlow) {
      return const SignParent();
    }

    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Welcome to Multitalk AAC',
                        style: AppTheme.displayLarge,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your Inclusive Communication Companion',
                        style: AppTheme.titleLarge,
                      ),
                      const SizedBox(height: 32),
                      const CustomFeatureCard(
                        icon: Icons.language,
                        title: 'Multilingual Support',
                        description: 'Communication tools in Malay and English',
                      ),
                      const CustomFeatureCard(
                        icon: Icons.school,
                        title: 'Interactive Learning',
                        description:
                            'Engaging modules designed for children with speech delays',
                      ),
                      const CustomFeatureCard(
                        icon: Icons.family_restroom,
                        title: 'Parent-Guided Progress',
                        description:
                            'Tools and guidance for parents to support their child\'s communication journey',
                      ),
                      const CustomFeatureCard(
                        icon: Icons.track_changes,
                        title: 'Progress Tracking',
                        description:
                            'Monitor and celebrate communication milestones',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // This sets the state to true, meaning "we're now in auth flow"
                    ref.read(isAuthFlowProvider.notifier).state = true;
                  },
                  style: AppTheme.primaryButtonStyle,
                  child: const Text(
                    'Get Started',
                    style: AppTheme.buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
