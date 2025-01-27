// lib/screens/parent_screens/reports_screen/components/week_progress.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class WeekProgress extends StatelessWidget {
  final String childId;

  const WeekProgress({
    super.key,
    required this.childId,
  });

  Stream<List<bool>> _getWeekProgress() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return FirebaseFirestore.instance
        .collection('children')
        .doc(childId)
        .collection('progress')
        .doc('weekly')
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return List.generate(7, (index) => false);
      }

      final List<dynamic> days = snapshot.data()?['days'] ?? [];
      return List.generate(7, (index) {
        final day = startOfWeek.add(Duration(days: index));
        return days.contains(day.toString().split(' ')[0]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<bool>>(
      stream: _getWeekProgress(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final weekProgress = snapshot.data!;
        const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              final isActive = weekProgress[index];
              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? AppTheme.accentGreen
                          : AppTheme.accentGreen.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.water_drop,
                      color: isActive ? Colors.white : AppTheme.accentGreen,
                      size: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    days[index],
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.secondaryBrown,
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
