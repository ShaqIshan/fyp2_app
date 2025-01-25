import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/bottom_nav_bar_child/child_bottom_nav.dart';
import 'package:fyp2_app/Screens/child_screens/child_home_screen/home/child_home.dart';
import 'package:fyp2_app/Screens/child_screens/child_visual_schedule_screen/child_visual_schedule.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import 'child_aac_board_screen/aac_board_screen.dart';

enum ChildView { home, aacBoard, schedule }

class ChildWrapper extends StatefulWidget {
  const ChildWrapper({super.key});

  @override
  State<ChildWrapper> createState() => _ChildWrapperState();
}

class _ChildWrapperState extends State<ChildWrapper> {
  ChildView _currentView = ChildView.home;
  int _currentIndex = 0;

  void _handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _currentView = ChildView.home;
          break;
        case 1:
          _currentView = ChildView.aacBoard;
          break;
        case 2:
          _currentView = ChildView.schedule;
          break;
      }
    });
  }

  Widget _getCurrentScreen() {
    switch (_currentView) {
      case ChildView.home:
        return const ChildJourneyHome();
      case ChildView.aacBoard:
        return const ChildAACBoard();
      case ChildView.schedule:
        return const ChildVisualSchedule();
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
