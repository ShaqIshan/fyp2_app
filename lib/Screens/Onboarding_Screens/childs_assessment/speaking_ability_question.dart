// lib/screens/assessment/questions/speaking_ability_question.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class SpeakingAbilityQuestion extends StatefulWidget {
  const SpeakingAbilityQuestion({
    super.key,
    required this.onAnswerSelected,
  });

  final Function(String) onAnswerSelected;

  @override
  State<SpeakingAbilityQuestion> createState() =>
      _SpeakingAbilityQuestionState();
}

class _SpeakingAbilityQuestionState extends State<SpeakingAbilityQuestion> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How does your child typically communicate verbally?',
              style: AppTheme.headingLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Consider their usual way of expressing needs and thoughts',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.secondaryBrown,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildOptionButton(
              'Non-verbal or minimal sounds',
              'Primarily uses gestures or makes simple sounds',
              'low',
            ),
            const SizedBox(height: 16),
            _buildOptionButton(
              'Basic verbal responses',
              'Can say yes/no and some basic words',
              'medium',
            ),
            const SizedBox(height: 16),
            _buildOptionButton(
              'Clear verbal communication',
              'Can express needs clearly with words',
              'high',
            ),
          ],
        ),
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
