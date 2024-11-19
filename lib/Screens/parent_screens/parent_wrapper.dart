// lib/screens/parent_screens/parent_wrapper.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/parent_screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_dashboard_screens/settings_screens/settings_wrapper.dart';
import 'package:fyp2_app/screens/parent_screens/parent_dashboard_screens/parent_dashboard.dart';
import 'package:fyp2_app/screens/parent_screens/visual_schedule_screen/visual_schedule_screen.dart';
import 'package:fyp2_app/shared/app_theme.dart';

// TODO: put this in a separate model class
enum ParentView {
  dashboard,
  learning,
  reports,
  schedule,
  settings,
}

class ParentWrapper extends StatefulWidget {
  const ParentWrapper({super.key});

  @override
  State<ParentWrapper> createState() => _ParentWrapperState();
}

class _ParentWrapperState extends State<ParentWrapper> {
  ParentView _currentView = ParentView.dashboard;
  int _currentIndex = 0;

  void _handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _currentView = ParentView.dashboard;
          break;
        case 1:
          _currentView = ParentView.learning;
          break;
        case 2:
          _currentView = ParentView.reports;
          break;
        case 3:
          _currentView = ParentView.schedule;
          break;
      }
    });
  }

  Widget _getCurrentScreen() {
    switch (_currentView) {
      case ParentView.dashboard:
        return ParentDashboard(
          onSettingsPressed: () {
            setState(() {
              _currentView = ParentView.settings;
            });
          },
        );
      case ParentView.learning:
        return const Placeholder(key: Key('learning'));
      case ParentView.reports:
        return const Placeholder(key: Key('reports'));
      case ParentView.schedule:
        return const VisualScheduleScreen();
      case ParentView.settings:
        return SettingsWrapper(
          onBackPressed: () {
            setState(() {
              _currentView = ParentView.dashboard;
            });
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showBottomNav = _currentView != ParentView.settings;

    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      body: _getCurrentScreen(),
      bottomNavigationBar: showBottomNav
          ? BottomNavBar(
              currentIndex: _currentIndex,
              onNavigation: _handleNavigation,
              onChildModePressed: () {
                // TODO: Implement child mode navigation
              },
            )
          : null,
    );
  }
}
