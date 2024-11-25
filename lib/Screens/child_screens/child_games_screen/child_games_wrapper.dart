// lib/screens/child/child_games_wrapper.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/Modules/everyday_basics_wrapper/everyday_basics_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/models/activity_category.dart';
import 'package:fyp2_app/shared/child_screen_shared/child_games_screen/activity_card.dart';
import 'package:fyp2_app/shared/child_screen_shared/child_games_screen/child_game_styles.dart';

// Create an enum to manage different views
enum GameView {
  categoryList,
  everydayBasics,
  storyTime,
  numbersInAction,
}

class ChildGamesWrapper extends StatefulWidget {
  const ChildGamesWrapper({super.key});

  @override
  State<ChildGamesWrapper> createState() => ChildGamesWrapperState();
}

class ChildGamesWrapperState extends State<ChildGamesWrapper> {
  GameView _currentView = GameView.categoryList;

  final List<ActivityCategory> categories = [
    ActivityCategory(
      title: 'Everyday Basics',
      subtitle: '13 Games',
      icon: Icons.self_improvement,
      backgroundColor: AppTheme.childTurquoise,
      totalItems: 13,
    ),
    ActivityCategory(
      title: 'Story Time!',
      subtitle: '11 Books',
      icon: Icons.auto_stories,
      backgroundColor: AppTheme.childPurple,
      totalItems: 11,
    ),
    ActivityCategory(
      title: 'Numbers in Action',
      subtitle: '7 Games',
      icon: Icons.onetwothree,
      backgroundColor: AppTheme.childPink,
      totalItems: 7,
    ),
  ];

  Widget _getCurrentView() {
    switch (_currentView) {
      case GameView.categoryList:
        return _buildCategoryListView();
      case GameView.everydayBasics:
        return EverydayBasicsWrapper(
          onBack: () => setState(() => _currentView = GameView.categoryList),
        );
      case GameView.storyTime:
        // TODO: Add StoryTimeWrapper
        return const Placeholder();
      case GameView.numbersInAction:
        // TODO: Add NumbersInActionWrapper
        return const Placeholder();
    }
  }

  Widget _buildCategoryListView() {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildActivityList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ChildGameStyles.headerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Let\'s Play!',
            style: AppTheme.childHeadingLarge,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: ChildGameStyles.starCounterDecoration,
            child: Row(
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
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ActivityCard(
          category: category,
          onTap: () {
            setState(() {
              // Set the appropriate view based on the category
              switch (index) {
                case 0:
                  _currentView = GameView.everydayBasics;
                  break;
                case 1:
                  _currentView = GameView.storyTime;
                  break;
                case 2:
                  _currentView = GameView.numbersInAction;
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
    return _getCurrentView();
  }
}
