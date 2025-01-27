// lib/screens/parent_screens/reports_screen/components/daily_stats.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class DailyStats extends StatelessWidget {
  final String childId;

  const DailyStats({
    super.key,
    required this.childId,
  });

  Stream<Map<String, dynamic>> _getDailyStats() {
    final today = DateTime.now().toString().split(' ')[0];
    return FirebaseFirestore.instance
        .collection('children')
        .doc(childId)
        .collection('progress')
        .doc(today)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return {
          'starsCollected': 0,
          'minutesPlayed': 0,
        };
      }
      return {
        'starsCollected': snapshot.data()?['starsCollected'] ?? 0,
        'minutesPlayed': snapshot.data()?['minutesPlayed'] ?? 0,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _getDailyStats(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final stats = snapshot.data!;

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
              _buildStatRow(
                icon: Icons.star,
                label: 'Stars Collected Today',
                value: '${stats['starsCollected']} points',
                color: AppTheme.accentGreen,
              ),
              const Divider(height: 32),
              _buildStatRow(
                icon: Icons.timer,
                label: 'Time Played Today',
                value: '${stats['minutesPlayed']} minutes',
                color: AppTheme.primaryBrown,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.secondaryBrown,
                ),
              ),
              Text(
                value,
                style: AppTheme.titleLarge.copyWith(
                  color: AppTheme.primaryBrown,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
