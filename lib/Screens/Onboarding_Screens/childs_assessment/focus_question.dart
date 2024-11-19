// lib/screens/assessment/questions/focus_question.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class FocusQuestion extends StatefulWidget {
  const FocusQuestion({
    super.key,
    required this.onAnswerSelected,
  });

  final Function(String) onAnswerSelected;

  @override
  State<FocusQuestion> createState() => _FocusQuestionState();
}

class _FocusQuestionState extends State<FocusQuestion> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Does your child focus when you\'re talking?',
            style: AppTheme.headingLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Consider their attention during conversations and instructions',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.secondaryBrown,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildOptionButton(
            'Consistently focused',
            'Maintains attention throughout conversations',
            'high',
          ),
          const SizedBox(height: 16),
          _buildOptionButton(
            'Sometimes focused',
            'Shows intermittent attention during conversations',
            'medium',
          ),
          const SizedBox(height: 16),
          _buildOptionButton(
            'Rarely focused',
            'Has difficulty maintaining attention during conversations',
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
