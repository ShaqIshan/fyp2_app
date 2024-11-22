import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ActivityCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final int totalItems;

  ActivityCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.totalItems,
  });
}

class ChildGamesWrapper extends StatefulWidget {
  const ChildGamesWrapper({super.key});

  @override
  State<ChildGamesWrapper> createState() => ChildGamesWrapperState();
}

class ChildGamesWrapperState extends State<ChildGamesWrapper> {
  final List<ActivityCategory> categories = [
    ActivityCategory(
      title: 'Everyday Basics',
      subtitle: '13 Games',
      icon: Icons.self_improvement,
      backgroundColor: AppTheme.childTurquoise,
      totalItems: 13,
    ),
    ActivityCategory(
      title: 'Story Time!',
      subtitle: '11 Books',
      icon: Icons.auto_stories,
      backgroundColor: AppTheme.childPurple,
      totalItems: 11,
    ),
    ActivityCategory(
      title: 'Numbers in Action',
      subtitle: '7 Games',
      icon: Icons.onetwothree,
      backgroundColor: AppTheme.childPink,
      totalItems: 7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildActivityList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Let\'s Play!',
            style: AppTheme.childHeadingLarge,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.childYellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppTheme.childYellow,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '0/6',
                  style: AppTheme.childTitleLarge.copyWith(
                    color: AppTheme.childYellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(ActivityCategory category) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: category.backgroundColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            print('Selected activity: ${category.title}');
            // TODO: Implement navigation to specific activity
          },
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  category.icon,
                  size: 120,
                  color: category.backgroundColor.withOpacity(0.2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      category.icon,
                      size: 40,
                      color: category.backgroundColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      category.title,
                      style: AppTheme.childHeadingMedium.copyWith(
                        color: category.backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: category.backgroundColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category.subtitle,
                        style: AppTheme.childBodyText.copyWith(
                          color: category.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildActivityCard(category);
      },
    );
  }
}
