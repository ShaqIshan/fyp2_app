import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/Inner_modules/coloring_fun_games/levels/cute_animals_level/cute_animals_level.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../../../../../models/childs_models/child_learning_modules_games/basic_skills/basic_activity.dart';
import 'Inner_modules/animal_matching_games/animal_matching_wrapper.dart';
import 'Inner_modules/drawing_practice_games/drawing_practice_wrapper.dart';
import 'all_elements/components/activity_card.dart';
import 'all_elements/components/basic_skills_header.dart';
import 'all_elements/components/basic_skills_progress.dart';
import 'all_elements/components/locked_activity_dialog.dart';
import 'all_elements/data/activities_data.dart';

// NOTE: progress bar is not visible because rewards is not implemented yet
// FIXME: implement progress bar properly

class BasicSkillsWrapper extends StatefulWidget {
  final VoidCallback onBack;

  const BasicSkillsWrapper({
    super.key,
    required this.onBack,
  });

  @override
  State<BasicSkillsWrapper> createState() => _BasicSkillsWrapperState();
}

class _BasicSkillsWrapperState extends State<BasicSkillsWrapper> {
  // Track total stars earned
  int earnedStars = 0;
  final int totalPossibleStars =
      12; // Total stars available across all activities

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BasicSkillsHeader(
              onBack: widget.onBack,
              currentStars: earnedStars,
              totalStars: totalPossibleStars,
            ),
            BasicSkillsProgress(
              progress: earnedStars / totalPossibleStars,
            ),
            Expanded(
              child: _buildActivitiesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitiesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ActivityCard(
            activity: activity,
            onTap: () => _handleActivityTap(activity),
          ),
        );
      },
    );
  }

  void _handleActivityTap(BasicActivity activity) {
    if (activity.isLocked) {
      _showLockedActivityDialog(activity);
    } else {
      _navigateToActivity(activity);
    }
  }

  void _showLockedActivityDialog(BasicActivity activity) {
    showDialog(
      context: context,
      builder: (context) => LockedActivityDialog(activity: activity),
    );
  }

  void _navigateToActivity(BasicActivity activity) async {
    Widget activityScreen;

    switch (activity.id) {
      case 'animal_matching':
        activityScreen = const AnimalMatchingWrapper();
        break;
      case 'drawing_practice':
        activityScreen = const DrawingPracticeWrapper();
        break;
      case 'coloring_fun':
        activityScreen = const CuteAnimalsLevel();
        break;
      default:
        activityScreen = const Placeholder();
    }

    // Navigate to the activity and wait for result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => activityScreen),
    );

    // Update stars if activity was completed
    if (result != null && result is int) {
      setState(() {
        earnedStars += result;

        // Update activities locked status based on new star count
        for (var i = 0; i < activities.length; i++) {
          if (activities[i].requiredStars <= earnedStars) {
            activities[i] = activities[i].copyWith(isLocked: false);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    // Add any cleanup here if needed
    super.dispose();
  }
}
