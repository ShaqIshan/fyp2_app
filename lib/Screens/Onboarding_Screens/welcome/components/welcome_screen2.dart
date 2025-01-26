import 'package:flutter/material.dart';
import 'feature_card.dart';
import 'screen_template.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScreenTemplate(
      title: 'Early Intervention',
      subtitle: 'Start Supporting Development Today',
      illustration: _buildFeatureGrid(),
      description:
          'Bridge the gap while waiting for professional support with our comprehensive learning modules.',
    );
  }

  Widget _buildFeatureGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: const [
        FeatureCard(
          icon: Icons.psychology,
          title: 'Communicate',
          color: Color(0xFFE3F2FD),
        ),
        FeatureCard(
          icon: Icons.school,
          title: 'Learning',
          color: Color(0xFFF3E5F5),
        ),
        FeatureCard(
          icon: Icons.schedule,
          title: 'Routines',
          color: Color(0xFFF1F8E9),
        ),
        FeatureCard(
          icon: Icons.track_changes,
          title: 'Progress',
          color: Color(0xFFFFF3E0),
        ),
      ],
    );
  }
}
