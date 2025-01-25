// lib/screens/child/home/components/journey_path.dart

import 'package:flutter/material.dart';
import '../models/level_data.dart';
import 'level_card.dart';

class JourneyPath extends StatelessWidget {
  final List<LevelData> levels;
  final Function(LevelData) onLevelTap;

  const JourneyPath({
    super.key,
    required this.levels,
    required this.onLevelTap,
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
            LevelCard(
              level: level,
              onTap: () => onLevelTap(level),
            ),
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
