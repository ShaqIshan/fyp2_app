// lib/screens/child_screens/child_home_screen/child_home.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/models/childs_models/level_data.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import 'components/child_home_header.dart';
import 'components/journey_path.dart';

class ChildJourneyHome extends StatelessWidget {
  const ChildJourneyHome({super.key});

  List<LevelData> _getMockLevels() {
    return [
      LevelData(
        id: 1,
        name: 'Animal Sounds',
        description: 'Learn animal sounds and names',
        icon: Icons.pets,
        color: AppTheme.childOrange,
        isCompleted: true,
      ),
      LevelData(
        id: 2,
        name: 'Word Magic',
        description: 'Match words with pictures',
        icon: Icons.auto_stories,
        color: AppTheme.childPurple,
        isCompleted: true,
      ),
      LevelData(
        id: 3,
        name: 'Story Time',
        description: 'Listen and tell stories',
        icon: Icons.menu_book,
        color: AppTheme.childTurquoise,
        isUnlocked: true,
      ),
      LevelData(
        id: 4,
        name: 'Talk Together',
        description: 'Practice conversations',
        icon: Icons.chat_bubble,
        color: AppTheme.childPink,
      ),
      LevelData(
        id: 5,
        name: 'Speech Star',
        description: 'Become a speaking champion',
        icon: Icons.star,
        color: AppTheme.childYellow,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final levels = _getMockLevels();

    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: Column(
        children: [
          const ChildHomeHeader(),
          Expanded(
            child: JourneyPath(levels: levels),
          ),
        ],
      ),
    );
  }
}
