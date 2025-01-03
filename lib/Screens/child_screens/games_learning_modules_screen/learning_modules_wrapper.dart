import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/games_learning_modules_screen/Modules/basic_skills/basic_skills_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/child_screen_shared/child_games_screen/activity_card.dart';
import 'package:fyp2_app/shared/child_screen_shared/child_games_screen/child_game_styles.dart';

import '../../../models/childs_models/child_learning_modules_games/basic_skills/inner_modules/inner_modules_cards.dart';

// Enum to manage different learning modules
enum LearningModule {
  moduleList,
  basicSkills,
  readingAdventures,
  mathExploration,
}

class LearningModulesWrapper extends StatefulWidget {
  const LearningModulesWrapper({super.key});

  @override
  State<LearningModulesWrapper> createState() => LearningModulesWrapperState();
}

class LearningModulesWrapperState extends State<LearningModulesWrapper> {
  LearningModule _currentModule = LearningModule.moduleList;

  final List<ActivityCategory> learningModules = [
    ActivityCategory(
      title: 'Basic Skills',
      subtitle: 'Practice essential skills',
      icon: Icons.self_improvement,
      backgroundColor: AppTheme.childTurquoise,
      totalItems: 13,
    ),
    ActivityCategory(
      title: 'Reading Adventures',
      subtitle: 'Explore stories & words',
      icon: Icons.auto_stories,
      backgroundColor: AppTheme.childPurple,
      totalItems: 11,
    ),
    ActivityCategory(
      title: 'Math Exploration',
      subtitle: 'Learn numbers & counting',
      icon: Icons.onetwothree,
      backgroundColor: AppTheme.childPink,
      totalItems: 7,
    ),
  ];

  Widget _getCurrentModule() {
    switch (_currentModule) {
      case LearningModule.moduleList:
        return _buildModuleListView();
      case LearningModule.basicSkills:
        return BasicSkillsWrapper(
          onBack: () =>
              setState(() => _currentModule = LearningModule.moduleList),
        );
      case LearningModule.readingAdventures:
        // TODO: Implement Reading Adventures module
        return const Placeholder();
      case LearningModule.mathExploration:
        // TODO: Implement Math Exploration module
        return const Placeholder();
    }
  }

  Widget _buildModuleListView() {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildModulesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: ChildGameStyles.headerDecoration,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Learning Adventures',
              style: AppTheme.childHeadingLarge.copyWith(
                fontSize: 28, // Slightly reduced font size
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ChildGameStyles.starCounterDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: AppTheme.childYellow,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '0/6',
            style: AppTheme.childTitleLarge.copyWith(
              color: AppTheme.childYellow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModulesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: learningModules.length,
      itemBuilder: (context, index) {
        final module = learningModules[index];
        return ActivityCard(
          category: module,
          onTap: () {
            setState(() {
              switch (index) {
                case 0:
                  _currentModule = LearningModule.basicSkills;
                  break;
                case 1:
                  _currentModule = LearningModule.readingAdventures;
                  break;
                case 2:
                  _currentModule = LearningModule.mathExploration;
                  break;
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getCurrentModule();
  }
}
