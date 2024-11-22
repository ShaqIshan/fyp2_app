import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/child_name/child_name_input.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/eye_contact_question.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/hyperactive_question.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/word_usage_question.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/speaking_ability_question.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/obsessive_behavior_question.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/childs_assessment/focus_question.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class AssessWrapper extends StatefulWidget {
  final String childName;
  final bool isFromProfileManagement;
  final bool isFromDashboard; // Add this flag

  const AssessWrapper({
    super.key,
    required this.childName,
    this.isFromProfileManagement = false,
    this.isFromDashboard = false, // Add default value
  });

  @override
  State<AssessWrapper> createState() => _AssessWrapperState();
}

class _AssessWrapperState extends State<AssessWrapper> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 6;

  void _goBack() {
    if (_currentPage > 0) {
      _previousPage();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChildNameInput(
            isFromProfileManagement: widget.isFromProfileManagement,
            isFromDashboard: widget.isFromDashboard,
          ),
        ),
      );
    }
  }

  // Store answers for each question
  final List<String?> _answers = List.filled(6, null);

  void _nextPage() {
    // Check if current question has an answer
    if (_answers[_currentPage] == null) {
      _showNoAnswerDialog();
      return;
    }

    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitAssessment();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showNoAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please Select an Answer',
            style: AppTheme.headingMedium,
          ),
          content: Text(
            'You need to select an answer before proceeding.',
            style: AppTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: AppTheme.titleMedium.copyWith(
                  color: AppTheme.accentGreen,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onAnswerSelected(int questionIndex, String answer) {
    setState(() {
      _answers[questionIndex] = answer;
    });
  }

  void _submitAssessment() {
    // Print all answers for child profile data
    print('\n--- Assessment Submission ---');
    print('Child Name: ${widget.childName}');
    print('Assessment Results:');
    for (int i = 0; i < _answers.length; i++) {
      print('Question ${i + 1}: ${_answers[i]}');
    }
    print('------------------------\n');

    // TODO: Implement state management
    // Will save child profile data using a state management solution
    // Example: context.read<ChildProfileProvider>().addProfile(newProfile);

    // Navigate to ParentWrapper
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ParentWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppTheme.primaryBrown,
          onPressed: _goBack, // Use replacement navigation
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (_currentPage + 1) / _totalPages,
                  backgroundColor: AppTheme.secondaryBrown.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.accentGreen,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Question ${_currentPage + 1} of $_totalPages',
                  style: AppTheme.titleMedium.copyWith(
                    color: AppTheme.secondaryBrown,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Question pages
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                EyeContactQuestion(
                  onAnswerSelected: (answer) => _onAnswerSelected(0, answer),
                ),
                HyperactiveQuestion(
                  onAnswerSelected: (answer) => _onAnswerSelected(1, answer),
                ),
                WordUsageQuestion(
                  onAnswerSelected: (answer) => _onAnswerSelected(2, answer),
                ),
                SpeakingAbilityQuestion(
                  onAnswerSelected: (answer) => _onAnswerSelected(3, answer),
                ),
                ObsessiveBehaviorQuestion(
                  onAnswerSelected: (answer) => _onAnswerSelected(4, answer),
                ),
                FocusQuestion(
                  onAnswerSelected: (answer) => _onAnswerSelected(5, answer),
                ),
              ],
            ),
          ),

          // Navigation button
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextPage,
                style: AppTheme.primaryButtonStyle,
                child: Text(
                  _currentPage < _totalPages - 1 ? 'Next' : 'Complete',
                  style: AppTheme.buttonTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
