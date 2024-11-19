import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ObsessiveBehaviorQuestion extends StatefulWidget {
  const ObsessiveBehaviorQuestion({
    super.key,
    required this.onAnswerSelected,
  });

  final Function(String) onAnswerSelected;

  @override
  State<ObsessiveBehaviorQuestion> createState() =>
      _ObsessiveBehaviorQuestionState();
}

class _ObsessiveBehaviorQuestionState extends State<ObsessiveBehaviorQuestion> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Does your child show repetitive behaviors like spinning?',
            style: AppTheme.headingLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Consider frequency of repetitive movements or focused behaviors',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.secondaryBrown,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildOptionButton(
            'Always',
            'Shows repetitive behaviors multiple times daily',
            'high',
          ),
          const SizedBox(height: 16),
          _buildOptionButton(
            'Sometimes',
            'Shows occasional repetitive behaviors',
            'medium',
          ),
          const SizedBox(height: 16),
          _buildOptionButton(
            'Rarely',
            'Seldom shows repetitive behaviors',
            'low',
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String title, String description, String value) {
    final isSelected = selectedAnswer == value;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedAnswer = value;
        });
        // For now, just print the selected value
        // TODO: Implement state management to store this value
        widget.onAnswerSelected(value);
        print(value);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppTheme.accentGreen : Colors.white,
        foregroundColor: isSelected ? Colors.white : AppTheme.textDark,
        padding: const EdgeInsets.all(20),
        elevation: isSelected ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected
                ? AppTheme.accentGreen
                : AppTheme.secondaryBrown.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTheme.titleMedium.copyWith(
              color: isSelected ? Colors.white : AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTheme.bodyMedium.copyWith(
              color: isSelected
                  ? Colors.white.withOpacity(0.8)
                  : AppTheme.secondaryBrown,
            ),
          ),
        ],
      ),
    );
  }
}
