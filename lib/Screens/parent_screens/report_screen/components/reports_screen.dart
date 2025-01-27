// lib/screens/parent_screens/reports_screen/reports_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'activity_summary.dart';
import 'daily_stats.dart';
import 'week_progress.dart';

class ReportsScreen extends StatelessWidget {
  final String selectedChildId;

  const ReportsScreen({
    super.key,
    required this.selectedChildId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: AppTheme.displayLarge.copyWith(
                        fontSize: 32,
                        color: AppTheme.primaryBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateTime.now().toString().split(' ')[0],
                      style: AppTheme.titleLarge.copyWith(
                        color: AppTheme.secondaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              ActivitySummary(childId: selectedChildId),
              WeekProgress(childId: selectedChildId),
              DailyStats(childId: selectedChildId),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to detailed report
                    },
                    style: AppTheme.primaryButtonStyle,
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('See Detailed Report'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
