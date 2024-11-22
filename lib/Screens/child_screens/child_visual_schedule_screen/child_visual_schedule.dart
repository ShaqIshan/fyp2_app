import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ChildVisualSchedule extends StatelessWidget {
  const ChildVisualSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock schedule data - TODO: Replace with state management later
    final List<Map<String, dynamic>> schedule = [
      {
        'time': '8:00am-10:00am',
        'activity': 'Learn',
        'icon': Icons.school,
        'color': AppTheme.childTurquoise,
      },
      {
        'time': '5:00pm-6:30pm',
        'activity': 'Play',
        'icon': Icons.sports_baseball,
        'color': AppTheme.childPurple,
      },
      {
        'time': '9:00pm',
        'activity': 'Sleep',
        'icon': Icons.bedtime,
        'color': AppTheme.childPink,
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Day',
          style: AppTheme.childHeadingLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTimelineIndicator(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: schedule.length,
              itemBuilder: (context, index) {
                final item = schedule[index];
                return _buildScheduleItem(item,
                    isLast: index == schedule.length - 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTimeIndicator(
              'Morning', Icons.wb_sunny_outlined, AppTheme.childOrange),
          _buildTimeIndicator(
              'Afternoon', Icons.wb_cloudy_outlined, AppTheme.childTurquoise),
          _buildTimeIndicator(
              'Night', Icons.nights_stay_outlined, AppTheme.childPurple),
        ],
      ),
    );
  }

  Widget _buildTimeIndicator(String label, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.childBodyText.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> item, {bool isLast = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (!isLast)
              Padding(
                padding: const EdgeInsets.only(left: 44, top: 70),
                child: Container(
                  width: 2,
                  height: 60,
                  color: item['color'].withOpacity(0.3),
                ),
              ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppTheme.childCream,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: item['color'].withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: item['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        item['icon'],
                        color: item['color'],
                        size: 40,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item['activity'],
                              style: AppTheme.childHeadingMedium.copyWith(
                                color: item['color'],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['time'],
                              style: AppTheme.childBodyText.copyWith(
                                color: item['color'].withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
