import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';
import 'package:fyp2_app/services/schedule_service.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/parents_screen_shared/shared_parents_screen/shared_schedule_item_widget.dart';
import 'package:intl/intl.dart';

import '../../visual_schedule_screen/screens/add_visual_schedule_screen.dart';

class UpcomingActivitiesSection extends StatelessWidget {
  final String selectedChildId;
  final ScheduleService scheduleService;

  const UpcomingActivitiesSection({
    super.key,
    required this.selectedChildId,
    required this.scheduleService,
  });

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'learn':
        return Icons.school;
      case 'eat':
        return Icons.restaurant;
      case 'play':
        return Icons.sports_esports;
      case 'sleep':
        return Icons.bedtime;
      case 'bath':
        return Icons.bathtub;
      case 'exercise':
        return Icons.fitness_center;
      case 'medicine':
        return Icons.medication;
      case 'dress':
        return Icons.checkroom;
      case 'potty':
        return Icons.wc;
      case 'art':
        return Icons.palette;
      case 'music':
        return Icons.music_note;
      case 'story':
        return Icons.menu_book;
      case 'outside':
        return Icons.park;
      case 'therapy':
        return Icons.psychology;
      case 'doctor':
        return Icons.local_hospital;
      case 'friends':
        return Icons.group;
      case 'transport':
        return Icons.directions_car;
      case 'chores':
        return Icons.cleaning_services_outlined;
      case 'screen':
        return Icons.tv;
      default:
        return Icons.event_note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Activities',
              style: AppTheme.headingMedium,
            ),
            TextButton.icon(
              onPressed: () => _navigateToAddSchedule(context),
              icon: const Icon(
                Icons.add,
                size: 20,
                color: AppTheme.accentGreen,
              ),
              label: Text(
                'Add',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.accentGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: StreamBuilder<List<Schedule>>(
            stream: scheduleService.getUpcomingSchedules(selectedChildId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(
                    'Stream error: ${snapshot.error}'); // Add this to see the actual error
                return Center(
                  child: Text(
                    'Error loading schedules: ${snapshot.error}', // Modify this to show the actual error
                    style: AppTheme.bodyMedium.copyWith(color: Colors.red),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final schedules = snapshot.data ?? [];

              if (schedules.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_available,
                        size: 48,
                        color: AppTheme.secondaryBrown.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No upcoming activities',
                        style: AppTheme.titleMedium.copyWith(
                          color: AppTheme.secondaryBrown,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => _navigateToAddSchedule(context),
                        child: Text(
                          'Add Activity',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.accentGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getCategoryIcon(schedule.category),
                            color: AppTheme.accentGreen,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${DateFormat('h:mm a').format(schedule.startTime)} - ${schedule.name}',
                              style: AppTheme.bodyMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.accentGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              _getScheduleStatus(schedule.startTime),
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.accentGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToAddSchedule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddScheduleScreen(
          selectedChildId: selectedChildId,
        ),
      ),
    );
  }

  String _getScheduleStatus(DateTime scheduleTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dayAfter = today.add(const Duration(days: 2));

    final scheduleDate =
        DateTime(scheduleTime.year, scheduleTime.month, scheduleTime.day);

    // If schedule is within next hour, show "Soon"
    if (scheduleTime.difference(now).inHours < 1 &&
        scheduleDate.isAtSameMomentAs(today)) {
      return 'Soon';
    }

    // Compare dates
    if (scheduleDate.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (scheduleDate.isAtSameMomentAs(tomorrow)) {
      return 'Tomorrow';
    } else if (scheduleDate.isAfter(tomorrow)) {
      // You could also return the actual date here if you prefer
      return 'Upcoming';
    }

    return 'Today'; // Default fallback
  }
}
