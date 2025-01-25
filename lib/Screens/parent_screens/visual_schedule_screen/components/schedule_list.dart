import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'schedule_item_card.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> schedules;
  final Function(String) onDeleteSchedule;
  final Function(Schedule) onEditSchedule;
  final DateTime selectedDate;

  const ScheduleList({
    super.key,
    required this.schedules,
    required this.onDeleteSchedule,
    required this.onEditSchedule,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    if (schedules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: AppTheme.secondaryBrown.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No schedules for this date',
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.secondaryBrown.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return ScheduleItemCard(
          schedule: schedule,
          onDelete: () => onDeleteSchedule(schedule.id),
          onEdit: () => onEditSchedule(schedule),
        );
      },
    );
  }
}
