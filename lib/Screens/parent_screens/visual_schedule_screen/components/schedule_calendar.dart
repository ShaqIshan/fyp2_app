// lib/screens/parent_screens/visual_schedule/components/schedule_calendar.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final CalendarFormat calendarFormat;
  final Function(CalendarFormat)? onFormatChanged;
  final bool showInContainer;

  const ScheduleCalendar({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    this.calendarFormat = CalendarFormat.week,
    this.onFormatChanged,
    this.showInContainer = true,
  });

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.now().subtract(const Duration(days: 365)),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      calendarFormat: calendarFormat,
      onFormatChanged: onFormatChanged,
      headerStyle: HeaderStyle(
        formatButtonVisible: onFormatChanged != null,
        formatButtonDecoration: BoxDecoration(
          color: AppTheme.accentGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        formatButtonTextStyle: AppTheme.bodyMedium.copyWith(
          color: AppTheme.accentGreen,
        ),
        titleCentered: true,
        titleTextStyle: AppTheme.titleLarge,
        leftChevronIcon: const Icon(
          Icons.chevron_left,
          color: AppTheme.accentGreen,
        ),
        rightChevronIcon: const Icon(
          Icons.chevron_right,
          color: AppTheme.accentGreen,
        ),
      ),
      calendarStyle: CalendarStyle(
        selectedDecoration: const BoxDecoration(
          color: AppTheme.accentGreen,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: AppTheme.accentGreen.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        weekendTextStyle: AppTheme.bodyMedium.copyWith(
          color: AppTheme.secondaryBrown,
        ),
        defaultTextStyle: AppTheme.bodyMedium,
      ),
      onDaySelected: onDaySelected,
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, date, _) {
          return Center(
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: AppTheme.accentGreen,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: AppTheme.bodyMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
        todayBuilder: (context, date, _) {
          return Center(
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: AppTheme.accentGreen.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.accentGreen,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!showInContainer) {
      return _buildCalendar();
    }

    return Container(
      margin: const EdgeInsets.all(16),
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
      child: _buildCalendar(),
    );
  }
}
