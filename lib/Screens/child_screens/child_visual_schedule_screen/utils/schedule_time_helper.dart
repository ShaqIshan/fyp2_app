import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';

class ScheduleTimeHelper {
  static String formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  static String formatDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final minutes = duration.inMinutes;
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      return '$hours hour${hours > 1 ? 's' : ''}';
    }
    return '$minutes min';
  }

  static String getPeriodFromDateTime(DateTime dateTime) {
    final hour = dateTime.hour;
    if (hour >= 0 && hour < 12) return 'morning';
    if (hour >= 12 && hour < 17) return 'afternoon';
    return 'night';
  }

  static String getCurrentPeriod() {
    final now = TimeOfDay.now();
    if (now.hour >= 5 && now.hour < 12) return 'morning';
    if (now.hour >= 12 && now.hour < 17) return 'afternoon';
    return 'night';
  }

  static bool isCurrentActivity(Schedule schedule) {
    final now = DateTime.now();
    return now.isAfter(schedule.startTime) && now.isBefore(schedule.endTime);
  }

  static bool isNextActivity(
      Schedule schedule, List<Schedule> schedules, String currentPeriod) {
    final now = DateTime.now();
    final periodSchedules = schedules
        .where((s) => getPeriodFromDateTime(s.startTime) == currentPeriod)
        .toList();

    if (periodSchedules.isEmpty) return false;

    // Sort schedules by start time
    periodSchedules.sort((a, b) => a.startTime.compareTo(b.startTime));

    // Find the first schedule that hasn't started yet
    final nextSchedule = periodSchedules.firstWhere(
      (s) => s.startTime.isAfter(now),
      orElse: () => periodSchedules.first,
    );

    return schedule.id == nextSchedule.id && schedule.startTime.isAfter(now);
  }
}
