// lib/screens/parent_screens/visual_schedule/utils/schedule_helpers.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';

class ScheduleHelpers {
  static DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  static Future<bool> hasTimeConflict(
      List<Schedule> existingSchedules, DateTime start, DateTime end,
      {String? excludeScheduleId}) async {
    for (var schedule in existingSchedules) {
      // Skip comparing with itself if updating
      if (excludeScheduleId != null && schedule.id == excludeScheduleId)
        continue;

      // Check for overlap
      if ((start.isBefore(schedule.endTime) ||
              start.isAtSameMomentAs(schedule.endTime)) &&
          (end.isAfter(schedule.startTime) ||
              end.isAtSameMomentAs(schedule.startTime))) {
        return true;
      }
    }
    return false;
  }

  static TimeOfDay addDurationToTime(TimeOfDay time, int durationMinutes) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final newDateTime = dateTime.add(Duration(minutes: durationMinutes));
    return TimeOfDay(
      hour: newDateTime.hour,
      minute: newDateTime.minute,
    );
  }

  static bool isValidTimeRange(TimeOfDay start, TimeOfDay end) {
    final now = DateTime.now();
    final startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      start.hour,
      start.minute,
    );
    final endDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      end.hour,
      end.minute,
    );
    return endDateTime.isAfter(startDateTime);
  }
}
