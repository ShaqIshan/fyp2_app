// lib/screens/assessment/questions/eye_contact_question.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class EyeContactQuestion extends StatefulWidget {
  const EyeContactQuestion({
    super.key,
    required this.onAnswerSelected,
  });

  final Function(String) onAnswerSelected;

  @override
  State<EyeContactQuestion> createState() => _EyeContactQuestionState();
}

class _EyeContactQuestionState extends State<EyeContactQuestion> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Does your child maintain eye contact when speaking?',
              style: AppTheme.headingLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Consider their behavior during daily conversations',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.secondaryBrown,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildOptionButton(
              'Always maintains eye contact',
              'Child consistently looks at the speaker',
              'high',
            ),
            const SizedBox(height: 16),
            _buildOptionButton(
              'Sometimes maintains eye contact',
              'Child occasionally looks at the speaker',
              'medium',
            ),
            const SizedBox(height: 16),
            _buildOptionButton(
              'Rarely maintains eye contact',
              'Child seldom looks at the speaker',
              'low',
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
