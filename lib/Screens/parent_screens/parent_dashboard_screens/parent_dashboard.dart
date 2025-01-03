// lib/screens/parent_screens/parent_dashboard_screens/parent_dashboard.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/screens/parent_screens/parent_dashboard_screens/components/dashboard_header.dart';
import 'package:fyp2_app/screens/parent_screens/parent_dashboard_screens/components/recent_activities_section.dart';
import 'package:fyp2_app/screens/parent_screens/parent_dashboard_screens/components/upcoming_activities_section.dart';
import 'package:fyp2_app/services/schedule_service.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import 'components/dashboard_header.dart';
import 'components/recent_activities_section.dart';
import 'components/upcoming_activities_section.dart';

class ParentDashboard extends StatefulWidget {
  final String selectedChildId;
  final Function(String) onChildSelected;
  final Stream<QuerySnapshot> childrenStream;
  final VoidCallback onSettingsPressed;

  const ParentDashboard({
    super.key,
    required this.selectedChildId,
    required this.onChildSelected,
    required this.childrenStream,
    required this.onSettingsPressed,
  });

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  final _scheduleService = ScheduleService();
  String? selectedChildId;
  late Stream<QuerySnapshot> _childrenStream;

  @override
  void initState() {
    super.initState();
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
    widget.onChildSelected(childId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      body: Column(
        children: [
          DashboardHeader(
            selectedChildId: selectedChildId,
            childrenStream: _childrenStream,
            onChildSelected: _handleChildSelection,
            onSettingsPressed: widget.onSettingsPressed,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const RecentActivitiesSection(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: UpcomingActivitiesSection(
                      selectedChildId: selectedChildId ?? '',
                      scheduleService: _scheduleService,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
