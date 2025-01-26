import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp2_app/models/schedule.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/models/childs_models/visual_schedule/schedule_item.dart';
import 'package:fyp2_app/services/schedule_activity_service.dart';
import 'components/schedule_card.dart';
import 'components/time_period_indicator.dart';
import 'utils/schedule_style_helper.dart';
import 'utils/schedule_time_helper.dart';

class ChildVisualSchedule extends StatefulWidget {
  const ChildVisualSchedule({super.key});

  @override
  State<ChildVisualSchedule> createState() => _ChildVisualScheduleState();
}

class _ChildVisualScheduleState extends State<ChildVisualSchedule>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _selectedPeriod = 'morning';
  String? selectedChildId;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controller.forward();
    _selectedPeriod = ScheduleTimeHelper.getCurrentPeriod();
    _getCurrentChild();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePeriodSelection(String period) {
    setState(() {
      _selectedPeriod = period;
      // Reset and restart the animation controller
      _controller.reset();
      _controller.forward();
    });
  }

  Future<void> _getCurrentChild() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (mounted) {
        setState(() {
          selectedChildId = userDoc.data()?['selectedChildId'] as String?;
          print('Current selected child ID: $selectedChildId'); // Debug print
        });
      }
    } catch (e) {
      print('Error getting current child: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: SafeArea(
        child: Column(
          children: [
            TimePeriodIndicator(
              controller: _controller,
              selectedPeriod: _selectedPeriod,
              onPeriodSelected: _handlePeriodSelection,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('schedules')
                    .where('childId', isEqualTo: selectedChildId)
                    .where('startTime',
                        isGreaterThanOrEqualTo: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        ))
                    .where('startTime',
                        isLessThan: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        ).add(const Duration(days: 1)))
                    .orderBy('startTime')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _buildErrorState();
                  }

                  if (!snapshot.hasData) {
                    return _buildLoadingState();
                  }

                  final schedules = _parseSchedules(snapshot.data!);
                  final filteredSchedules = _filterSchedulesByPeriod(schedules);

                  if (filteredSchedules.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildScheduleList(filteredSchedules);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Schedule> _parseSchedules(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          try {
            return Schedule(
              id: doc.id,
              childId: data['childId'],
              name: data['name'],
              date: (data['startTime'] as Timestamp).toDate(),
              startTime: (data['startTime'] as Timestamp).toDate(),
              endTime: (data['endTime'] as Timestamp).toDate(),
              category: data['category'] ?? 'Activity',
            );
          } catch (e) {
            print('Error parsing schedule: $e');
            return null;
          }
        })
        .where((schedule) => schedule != null)
        .cast<Schedule>()
        .toList();
  }

  List<Schedule> _filterSchedulesByPeriod(List<Schedule> schedules) {
    return schedules
        .where((schedule) =>
            ScheduleTimeHelper.getPeriodFromDateTime(schedule.startTime) ==
            _selectedPeriod)
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  Widget _buildScheduleList(List<Schedule> schedules) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        final animation = CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (index / schedules.length) * 0.5,
            ((index + 1) / schedules.length) * 0.5,
            curve: Curves.easeOut,
          ),
        );

        // Determine next status synchronously
        final isNext = ScheduleTimeHelper.isNextActivity(
            schedule, schedules, _selectedPeriod);

        return ScheduleCard(
          item: ScheduleItem(
            id: schedule.id,
            time: ScheduleTimeHelper.formatTime(schedule.startTime),
            activity: schedule.name,
            icon: ScheduleStyleHelper.getCategoryIcon(schedule.category),
            color: ScheduleStyleHelper.getCategoryColor(schedule.category),
            period:
                ScheduleTimeHelper.getPeriodFromDateTime(schedule.startTime),
            duration: ScheduleTimeHelper.formatDuration(
              schedule.startTime,
              schedule.endTime,
            ),
          ),
          currentPeriod: _selectedPeriod,
          isActive: ScheduleTimeHelper.isCurrentActivity(schedule),
          isNext: isNext,
          slideAnimation: animation,
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppTheme.childPink.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: AppTheme.childTitleLarge.copyWith(
              color: AppTheme.childPink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please try again later',
            style: AppTheme.childBodyText.copyWith(
              color: AppTheme.childPink.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              color: AppTheme.childTurquoise,
              strokeWidth: 4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading schedules...',
            style: AppTheme.childBodyText.copyWith(
              color: AppTheme.childTurquoise,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: AppTheme.childTurquoise.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No activities for this time',
            style: AppTheme.childTitleLarge.copyWith(
              color: AppTheme.childTurquoise.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
