import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';
import 'package:fyp2_app/screens/parent_screens/visual_schedule_screen/add_visual_schedule_screen.dart';
import 'package:fyp2_app/services/schedule_service.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCalendar(),
          Expanded(
            child: StreamBuilder<List<Schedule>>(
              stream:
                  _scheduleService.getChildSchedules(widget.selectedChildId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Error loading schedules: ${snapshot.error}',
                        style: AppTheme.bodyMedium.copyWith(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.accentGreen,
                    ),
                  );
                }

                final schedules = snapshot.data!;
                final selectedDateSchedules = schedules
                    .where((schedule) =>
                        schedule.date.year == _selectedDay.year &&
                        schedule.date.month == _selectedDay.month &&
                        schedule.date.day == _selectedDay.day)
                    .toList()
                  ..sort((a, b) => a.startTime.compareTo(b.startTime));

                if (selectedDateSchedules.isEmpty) {
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
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () => _navigateToAddSchedule(),
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: AppTheme.accentGreen,
                          ),
                          label: Text(
                            'Add Schedule',
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
                  padding: const EdgeInsets.all(16),
                  itemCount: selectedDateSchedules.length,
                  itemBuilder: (context, index) {
                    final schedule = selectedDateSchedules[index];
                    return _buildScheduleItem(schedule);
                  },
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        '  Schedule',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }

  Widget _buildCalendar() {
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
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: CalendarFormat.week,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
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
        ),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }

  Widget _buildScheduleItem(Schedule schedule) {
    return Dismissible(
      key: Key(schedule.id),
      background: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Schedule'),
              content: Text(
                'Are you sure you want to delete "${schedule.name}"?',
                style: AppTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.secondaryBrown,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) async {
        try {
          await _scheduleService.deleteSchedule(schedule.id);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Deleted "${schedule.name}"'),
                backgroundColor: AppTheme.accentGreen,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to delete schedule'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16),
              ),
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(schedule.category),
              color: AppTheme.accentGreen,
              size: 24,
            ),
          ),
          title: Text(
            schedule.name,
            style: AppTheme.titleMedium,
          ),
          subtitle: Text(
            '${DateFormat.jm().format(schedule.startTime)} - ${DateFormat.jm().format(schedule.endTime)}',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.secondaryBrown,
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              schedule.category,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.accentGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String? category) {
    // If category is null or empty, return generic activity icon
    if (category == null || category.isEmpty) {
      return Icons.event_note;
    }

    switch (category.toLowerCase()) {
      // Basic categories
      case 'learn':
        return Icons.school;
      case 'play':
        return Icons.sports_esports;
      case 'sleep':
        return Icons.bedtime;
      case 'eat':
        return Icons.restaurant;
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
      case 'brush teeth':
        return Icons.cleaning_services;
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
      // Default case: return generic activity icon
      default:
        return Icons.event_note;
    }
  }

  void _navigateToAddSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddScheduleScreen(
          selectedChildId: widget.selectedChildId,
        ),
      ),
    );
  }
}
