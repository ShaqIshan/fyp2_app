import 'package:flutter/material.dart';
import 'package:fyp2_app/Screens/Onboarding_Screens/child_name/child_name_input.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_dashboard_screens/settings_screens/settings_wrapper.dart';
import 'package:fyp2_app/Screens/parent_screens/parent_wrapper.dart';
import 'package:fyp2_app/Screens/parent_screens/visual_schedule_screen/add_visual_schedule_screen.dart';
import 'package:fyp2_app/models/child_profile.dart';
import 'package:fyp2_app/shared/app_theme.dart';
import 'package:fyp2_app/shared/parents_screen_shared/shared_parents_screen/activity_card_styles.dart';
import 'package:fyp2_app/shared/parents_screen_shared/shared_parents_screen/activity_card_widget.dart';
import 'package:fyp2_app/shared/parents_screen_shared/shared_parents_screen/shared_schedule_item_widget.dart';

class ParentDashboard extends StatefulWidget {
  final VoidCallback onSettingsPressed;

  const ParentDashboard({
    super.key,
    required this.onSettingsPressed,
  });

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  // Mock data - later this will come from your database
  final List<ChildProfile> children = [
    ChildProfile(name: 'Sophie', id: '1', speechDelayLevel: 'high'),
    ChildProfile(name: 'Alex', id: '2', speechDelayLevel: 'low'),
  ];
  String selectedChildId = '1'; // Default selected child

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildRecentActivities(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: _buildUpcomingActivities(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
      decoration: ActivityStyles.headerGradient,
      child: Column(
        children: [
          Row(
            children: [
              // Child selector dropdown
              Expanded(
                child: PopupMenuButton<String>(
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onSelected: (String value) {
                    if (value == 'add_new') {
                      // TODO: Navigate to add child screen
                      Future.delayed(const Duration(milliseconds: 100), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChildNameInput(
                              isFromDashboard: true,
                            ),
                          ),
                        );
                      });
                      print('Navigate to add child screen');
                    } else {
                      setState(() {
                        selectedChildId = value;
                      });
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        children
                            .firstWhere((child) => child.id == selectedChildId)
                            .name,
                        style: AppTheme.displayLarge.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  itemBuilder: (BuildContext context) => [
                    ...children.map((child) => PopupMenuItem<String>(
                          value: child.id,
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppTheme.accentGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    child.name[0],
                                    style: AppTheme.titleMedium.copyWith(
                                      color: AppTheme.accentGreen,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                child.name,
                                style: AppTheme.titleMedium,
                              ),
                              if (child.id == selectedChildId)
                                const Spacer()
                              else
                                const SizedBox.shrink(),
                              if (child.id == selectedChildId)
                                const Icon(
                                  Icons.check,
                                  color: AppTheme.accentGreen,
                                  size: 20,
                                ),
                            ],
                          ),
                        )),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'add_new',
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppTheme.accentGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: AppTheme.accentGreen,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Add New Child',
                            style: AppTheme.titleMedium.copyWith(
                              color: AppTheme.accentGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Settings button
              IconButton(
                onPressed: widget.onSettingsPressed, // Use the callback here

                // - Profile settings
                // - App preferences
                // - Notification settings
                // - Child profile management
                // - AAC board customization

                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildProgressIndicator(
                  icon: Icons.task_alt,
                  label: 'Daily Tasks',
                  count: '3/5',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProgressIndicator(
                  icon: Icons.trending_up,
                  label: 'Progress',
                  count: '85%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator({
    required IconData icon,
    required String label,
    required String count,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Text(
                count,
                style: AppTheme.titleMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Activities',
              style: AppTheme.headingMedium,
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to full activity history
              },
              child: Text(
                'View All',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.accentGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 145,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              SizedBox(
                width: 280,
                child: ActivityCard(
                  date: '27/5/2024',
                  title: 'Daily Routine passed',
                  category: 'AAC Needs',
                  isPositive: true,
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 280,
                child: ActivityCard(
                  date: '27/5/2024',
                  title: 'Struggling with Animal Safari',
                  category: 'Social Communication',
                  isPositive: false,
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 280,
                child: ActivityCard(
                  date: '27/5/2024',
                  title: 'Completed Morning Exercise',
                  category: 'Physical Activity',
                  isPositive: true,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingActivities(BuildContext context) {
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
              onPressed: () {
                // goes to add schedule screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddScheduleScreen(),
                  ),
                );
              },
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
        const Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ScheduleItem(
                  time: '8:00 AM',
                  activity: 'Learn',
                  status: 'Today',
                ),
                ScheduleItem(
                  time: '5:30 PM',
                  activity: 'Play',
                  status: 'Today',
                ),
                ScheduleItem(
                  time: '9:00 PM',
                  activity: 'Sleep',
                  status: 'Today',
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
