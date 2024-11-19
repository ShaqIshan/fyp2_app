// lib/screens/parent_screens/visual_schedule/visual_schedule_screen.dart

import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/parent_screens/visual_schedule_screen/add_visual_schedule_screen.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/shared_parents_vis_sched/schedule_item_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class VisualScheduleScreen extends StatefulWidget {
  const VisualScheduleScreen({super.key});

  @override
  State<VisualScheduleScreen> createState() => _VisualScheduleScreenState();
}

class _VisualScheduleScreenState extends State<VisualScheduleScreen> {
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
            child: _buildScheduleList(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Visual Schedule',
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddScheduleScreen(),
                  ),
                );
              },
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
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2024, 12, 31),
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

  // TODO: maybe change this to a model somehow
  Widget _buildScheduleList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        ScheduleItemWidget(
          time: '9:00 AM - 10:30 AM',
          title: 'Eat',
          icon: Icons.restaurant,
        ),
        SizedBox(height: 12),
        ScheduleItemWidget(
          time: '11:00 AM - 12:30 PM',
          title: 'Play',
          icon: Icons.sports_esports,
        ),
      ],
    );
  }
}
