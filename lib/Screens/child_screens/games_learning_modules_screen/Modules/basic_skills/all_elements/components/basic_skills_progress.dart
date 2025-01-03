import 'package:flutter/material.dart';
import 'package:fyp2_app/shared/app_theme.dart';

class BasicSkillsProgress extends StatelessWidget {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  const BasicSkillsProgress({
    super.key,
    required this.progress,
    this.progressColor = AppTheme.childTurquoise,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 12,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    progressColor,
                    progressColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
