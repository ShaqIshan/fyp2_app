import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class ChildJourneyHome extends StatelessWidget {
  const ChildJourneyHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock level data - Replace with state management later
    final levels = [
      _LevelData(
        id: 1,
        name: 'Animal Sounds',
        description: 'Learn animal sounds and names',
        icon: Icons.pets,
        color: AppTheme.childOrange,
        isCompleted: true,
      ),
      _LevelData(
        id: 2,
        name: 'Word Magic',
        description: 'Match words with pictures',
        icon: Icons.auto_stories,
        color: AppTheme.childPurple,
        isCompleted: true,
      ),
      _LevelData(
        id: 3,
        name: 'Story Time',
        description: 'Listen and tell stories',
        icon: Icons.menu_book,
        color: AppTheme.childTurquoise,
        isUnlocked: true,
      ),
      _LevelData(
        id: 4,
        name: 'Talk Together',
        description: 'Practice conversations',
        icon: Icons.chat_bubble,
        color: AppTheme.childPink,
      ),
      _LevelData(
        id: 5,
        name: 'Speech Star',
        description: 'Become a speaking champion',
        icon: Icons.star,
        color: AppTheme.childYellow,
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.childSkyBlue,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildJourneyPath(levels),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      decoration: BoxDecoration(
        color: AppTheme.childCream,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello Little',
                    style: AppTheme.childBodyText.copyWith(
                      color: AppTheme.childTurquoise.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    'Sophia',
                    style: AppTheme.childHeadingLarge.copyWith(
                      color: AppTheme.childTurquoise,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildStarsWidget(),
            ],
          ),
          const SizedBox(height: 24),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildStarsWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.childYellow.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.childYellow.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: AppTheme.childYellow,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            '25',
            style: AppTheme.childTitleLarge.copyWith(
              color: AppTheme.childYellow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    const progress = 0.6; // 60% progress
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Journey',
          style: AppTheme.childBodyText.copyWith(
            color: AppTheme.childTurquoise.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: AppTheme.childTurquoise.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    width: constraints.maxWidth * progress,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.childTurquoise,
                          AppTheme.childTurquoise.withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyPath(List<_LevelData> levels) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      itemCount: levels.length,
      itemBuilder: (context, index) {
        final level = levels[index];
        final isLast = index == levels.length - 1;

        return Column(
          children: [
            _buildLevelCard(level),
            if (!isLast)
              Container(
                margin: const EdgeInsets.only(left: 52),
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      level.isCompleted ? level.color : Colors.grey[300]!,
                      levels[index + 1].isCompleted ||
                              levels[index + 1].isUnlocked
                          ? levels[index + 1].color
                          : Colors.grey[300]!,
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLevelCard(_LevelData level) {
    final bool isActive = level.isCompleted || level.isUnlocked;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isActive ? 1.0 : 0.6,
      child: Transform.scale(
        scale: isActive ? 1.0 : 0.95,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.childCream,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: level.color.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              onTap: isActive
                  ? () {
                      // TODO: Navigate to level
                      print('Selected level: ${level.name}');
                    }
                  : null,
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: isActive
                            ? level.color.withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: level.isCompleted
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: level.color,
                              size: 36,
                            )
                          : Icon(
                              level.icon,
                              color: isActive ? level.color : Colors.grey[400],
                              size: 36,
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: level.color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Level ${level.id}',
                                  style: AppTheme.childBodyText.copyWith(
                                    color: level.color,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              if (level.isCompleted) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.star,
                                  color: AppTheme.childYellow,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '5',
                                  style: AppTheme.childBodyText.copyWith(
                                    color: AppTheme.childYellow,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            level.name,
                            style: AppTheme.childTitleLarge.copyWith(
                              color: isActive
                                  ? AppTheme.childTurquoise
                                  : Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            level.description,
                            style: AppTheme.childBodyText.copyWith(
                              color: isActive
                                  ? AppTheme.childTurquoise.withOpacity(0.7)
                                  : Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isActive && !level.isCompleted)
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: level.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: level.color,
                          size: 32,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LevelData {
  final int id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isCompleted;
  final bool isUnlocked;

  _LevelData({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.isCompleted = false,
    this.isUnlocked = false,
  });
}
