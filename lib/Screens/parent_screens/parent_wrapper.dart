import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/child_screens/child_wrapper.dart';
import 'package:fyp2_app/Screens/onboarding_screens/child_name/child_name_input.dart';
import 'package:fyp2_app/screens/parent_screens/bottom_nav_bar_parents/bottom_nav_bar.dart';
import 'package:fyp2_app/screens/parent_screens/parent_dashboard_screens/parent_dashboard.dart';
import 'package:fyp2_app/screens/parent_screens/parent_dashboard_screens/settings_screens/settings_wrapper.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import 'visual_schedule_screen/screens/visual_schedule_screen.dart';

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
  String? selectedChildId;
  late Stream<QuerySnapshot> _childrenStream;

  @override
  void initState() {
    super.initState();
    _initializeChildStream();
  }

  void _initializeChildStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _childrenStream = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('children')
          .snapshots();

      _loadInitialChild();
    }
  }

  Future<void> _loadInitialChild() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('children')
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty && mounted) {
          setState(() {
            selectedChildId = snapshot.docs.first.id;
          });
        }
      } catch (e) {
        debugPrint('Error loading initial child: $e');
      }
    }
  }

  void _handleChildSelection(String childId) {
    setState(() {
      selectedChildId = childId;
    });
  }

  void _handleNavigation(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          _currentView = ParentView.dashboard;
          break;
        case 1:
          _currentView = ParentView.schedule;

          break;
        case 2:
          _currentView = ParentView.reports;

          break;
      }
    });
  }

  void _navigateToAddChild() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChildNameInput(
          isFromDashboard: true,
        ),
      ),
    );
  }

  Widget _getCurrentScreen() {
    // If no child is selected and we're still loading, show loading indicator
    if (selectedChildId == null && _currentView != ParentView.settings) {
      return StreamBuilder<QuerySnapshot>(
        stream: _childrenStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No child profiles found',
                    style: AppTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _navigateToAddChild,
                    style: AppTheme.primaryButtonStyle,
                    child: const Text('Add Child Profile'),
                  ),
                ],
              ),
            );
          }

          // If we have data but no selected child, select the first one
          if (selectedChildId == null && snapshot.data!.docs.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                selectedChildId = snapshot.data!.docs.first.id;
              });
            });
          }

          return const Center(child: CircularProgressIndicator());
        },
      );
    }

    switch (_currentView) {
      case ParentView.dashboard:
        return ParentDashboard(
          selectedChildId: selectedChildId ?? '',
          onChildSelected: _handleChildSelection,
          childrenStream: _childrenStream,
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
        if (selectedChildId == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return VisualScheduleScreen(
          selectedChildId: selectedChildId!,
        );

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

  void _handleChildMode() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ChildWrapper()),
    );
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
              onChildModePressed: _handleChildMode,
            )
          : null,
    );
  }
}
