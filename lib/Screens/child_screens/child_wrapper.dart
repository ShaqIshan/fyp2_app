// lib/screens/child_screens/child_wrapper.dart
import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/bottom_nav_bar_child/child_bottom_nav.dart';
import 'package:fyp2_app/Screens/child_screens/child_aac_board_screen/child_aac_board.dart';
import 'package:fyp2_app/Screens/child_screens/child_games_screen/child_games_wrapper.dart';
import 'package:fyp2_app/Screens/child_screens/child_home_screen/child_home.dart';
import 'package:fyp2_app/Screens/child_screens/child_visual_schedule_screen/child_visual_schedule.dart';
import 'package:fyp2_app/shared/app_theme.dart';

enum ChildView { games, schedule, home, aacBoard }

class ChildWrapper extends StatefulWidget {
  const ChildWrapper({super.key});

  @override
  State<ChildWrapper> createState() => _ChildWrapperState();
}

class _ChildWrapperState extends State<ChildWrapper> {
  ChildView _currentView = ChildView.games;
  int _currentIndex = 1; // Start with games selected

  void _handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _currentView = ChildView.home;
          break;
        case 1:
          _currentView = ChildView.games;
          break;
        case 2:
          _currentView = ChildView.aacBoard;
          break;
        case 3:
          _currentView = ChildView.schedule;
          break;
      }
    });
  }

  Widget _getCurrentScreen() {
    switch (_currentView) {
      case ChildView.games:
        return const ChildGamesWrapper();
      case ChildView.schedule:
        return const ChildVisualSchedule();
      case ChildView.home:
        return const ChildJourneyHome();
      case ChildView.aacBoard:
        return const ChildAACBoard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _getCurrentScreen(),
      ),
      bottomNavigationBar: ChildBottomNav(
        selectedIndex: _currentIndex,
        onItemSelected: _handleNavigation,
      ),
    );
  }
}
