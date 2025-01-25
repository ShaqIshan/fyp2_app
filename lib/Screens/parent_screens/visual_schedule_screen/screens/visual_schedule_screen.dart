import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';
import 'package:fyp2_app/services/schedule_service.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import 'add_visual_schedule_screen.dart';
import 'edit_schedule_screen.dart';
import '../components/schedule_calendar.dart';
import '../components/schedule_list.dart';

class VisualScheduleScreen extends StatefulWidget {
  final String selectedChildId;

  const VisualScheduleScreen({
    super.key,
    required this.selectedChildId,
  });

  @override
  State<VisualScheduleScreen> createState() => _VisualScheduleScreenState();
}

class _VisualScheduleScreenState extends State<VisualScheduleScreen> {
  final _scheduleService = ScheduleService();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  void _handleDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  Future<void> _handleDeleteSchedule(String scheduleId) async {
    try {
      await _scheduleService.deleteSchedule(scheduleId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Schedule deleted successfully'),
            backgroundColor: AppTheme.accentGreen,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete schedule: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }

  void _handleEditSchedule(Schedule schedule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScheduleScreen(
          schedule: schedule,
          selectedChildId: widget.selectedChildId,
        ),
      ),
    );
  }

  void _navigateToAddSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddScheduleScreen(
          selectedChildId: widget.selectedChildId,
          initialDate: _selectedDay,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Schedule',
          style: AppTheme.headingMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Material(
              elevation: 4,
              color: AppTheme.accentGreen,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: _navigateToAddSchedule,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Add Schedule',
                        style: AppTheme.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ScheduleCalendar(
            selectedDay: _selectedDay,
            focusedDay: _focusedDay,
            onDaySelected: _handleDaySelected,
          ),
          Expanded(
            child: StreamBuilder<List<Schedule>>(
              stream: _scheduleService.getSchedulesForDate(
                widget.selectedChildId,
                _selectedDay,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading schedules: ${snapshot.error}',
                      style: AppTheme.bodyMedium.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final schedules = snapshot.data!
                  ..sort((a, b) => a.startTime.compareTo(b.startTime));

                return ScheduleList(
                  schedules: schedules,
                  onDeleteSchedule: _handleDeleteSchedule,
                  onEditSchedule: _handleEditSchedule,
                  selectedDate: _selectedDay,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddSchedule,
        backgroundColor: AppTheme.accentGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
