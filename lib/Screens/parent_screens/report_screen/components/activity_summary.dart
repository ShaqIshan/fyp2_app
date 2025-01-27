// lib/screens/parent_screens/reports_screen/components/activity_summary.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ActivitySummary extends StatelessWidget {
  final String childId;

  const ActivitySummary({
    super.key,
    required this.childId,
  });

  Stream<Map<String, dynamic>> _getActivityData() {
    return FirebaseFirestore.instance
        .collection('children')
        .doc(childId)
        .collection('progress')
        .doc('daily')
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return {
          'daysPlayed': 0,
          'totalDays': 31, // You can adjust this value
        };
      }
      return {
        'daysPlayed': snapshot.data()?['daysPlayed'] ?? 0,
        'totalDays': 31,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _getActivityData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!;
        final progress = (data['daysPlayed'] / data['totalDays']);

        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Days Played this week',
                    style: AppTheme.headingLarge,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        );
      },
    );
  }
}
