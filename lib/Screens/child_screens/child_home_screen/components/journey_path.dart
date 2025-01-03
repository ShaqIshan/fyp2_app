import 'package:flutter/material.dart';
import 'package:fyp2_app/models/childs_models/level_data.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import 'level_card.dart';

class JourneyPath extends StatelessWidget {
  final List<LevelData> levels;

  const JourneyPath({
    super.key,
    required this.levels,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      itemCount: levels.length,
      itemBuilder: (context, index) {
        final level = levels[index];
        final isLast = index == levels.length - 1;

        return Column(
          children: [
            LevelCard(level: level),
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
}
