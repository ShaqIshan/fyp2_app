// lib/screens/assessment/questions/word_usage_question.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class WordUsageQuestion extends StatefulWidget {
  const WordUsageQuestion({
    super.key,
    required this.onAnswerSelected,
  });

  final Function(String) onAnswerSelected;

  @override
  State<WordUsageQuestion> createState() => _WordUsageQuestionState();
}

class _WordUsageQuestionState extends State<WordUsageQuestion> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'How many words does your child use in a sentence?',
            style: AppTheme.headingLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Consider their typical communication style',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.secondaryBrown,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildOptionButton(
            'Single words only',
            'Uses one word at a time (e.g., "Water", "Play")',
            'low',
          ),
          const SizedBox(height: 16),
          _buildOptionButton(
            '2-3 words',
            'Uses short phrases (e.g., "Want water", "Play ball")',
            'medium',
          ),
          const SizedBox(height: 16),
          _buildOptionButton(
            'Full conversations',
            'Can engage in back-and-forth dialogue',
            'high',
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
